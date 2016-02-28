//
//  TwitterClient.swift
//  Twitter
//
//  Created by Arnold Ballesteros on 2/20/16.
//  Copyright © 2016 Arnold Ballesteros. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwittersClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwittersClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "FXbfn41cvtaSf7lqit497360j", consumerSecret: "t8cdQu8o58I8y7nQfEtwMPLzDw8uyeSY8xadTLfbPxeRlOtRxY")

    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func handleOpenUrl(url: NSURL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Access Token received")
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            }) { (error: NSError!) -> Void in
                print("Access Error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }

    }

    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
    
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:
            NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                success(tweets)
            
            }, failure: { (task:NSURLSessionDataTask?, error: NSError) -> Void in
               failure(error)
        })

    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            print("Access Error: \(error.localizedDescription)")
            failure(error)
        })
   

    
    }
    /*
    func createTweet(tweet:String,param: NSDictionary!, success: (User) -> (), failure: (NSError) -> ()) {
        POST("1.1/statuses/update.json?status=\(tweet)", parameters: param, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
           
            let tweetDictionary = response as! NSDictionary
            var updateTweet = Tweet(dictionary: tweetDictionary)
            
            }, failure: { (task: NSURLSessionDataTask?, error:NSError) -> Void in
            print("New Tweet Error : \(error.localizedDescription)")
            failure(error)
        })
    }
    */
    func tweetWithCompletion(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        
        POST("1.1/statuses/update.json?status=\(params!["status"] as! String)", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            var tweet = Tweet.tweetAsDictionary(response as! NSDictionary)
            
            
            completion(tweet: tweet, error: nil)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("ERROR: \(error)")
                completion(tweet: nil, error: error)
        }
    }
    func replyTweet(tweet:String, tweetID: Int, success: (User) -> () , failure: (NSError) -> ()) {
        var params = [String : AnyObject]()
        params["status"] = tweet
        params["in_reply_to_status-id"] = tweetID
        POST("1.1/statuses/update.json?in_reply_to_status_id=\(tweetID)&status=\(tweet)", parameters: params, constructingBodyWithBlock: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let tweetDictionary = response as! NSDictionary
            var updateTweet = Tweet(dictionary: tweetDictionary)
            }, failure: { (task: NSURLSessionDataTask?, error:NSError) -> Void in
            print("Reply Error : \(error.localizedDescription)")
        })
        
    }
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        //Clears Twitter of any previous logins
        TwittersClient.sharedInstance.deauthorize()
        //Request Authentication Token from Twitter
        TwittersClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            print("Request token received")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            
            //Open URL to different app e.g. safari, maps
            UIApplication.sharedApplication().openURL(url)
            
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
                
               
        }
    }
    
    
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
         NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    
}
