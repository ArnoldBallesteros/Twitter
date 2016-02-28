//
//  TweetingViewController.swift
//  Twitter
//
//  Created by Arnold Ballesteros on 2/27/16.
//  Copyright © 2016 Arnold Ballesteros. All rights reserved.
//

import UIKit

class TweetingViewController: UIViewController, UITextViewDelegate {
    
    var tweet: Tweet!
    var replyTweet: Tweet?

    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.delegate = self
        
        var newTweet = tweetText.text
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapTweet(sender: UIBarButtonItem) {
        if let replyTweet = replyTweet {
            print(tweetText.text)
            print(replyTweet.id)
            TwittersClient.sharedInstance.replyTweet(tweetText.text, tweetID: replyTweet.id!, success: { (User) -> () in
                var retweet = self.tweet!
            
                }, failure: { (error:NSError) -> () in
                    print("error: \(error.localizedDescription)")
            })
        } else {
            TwittersClient.sharedInstance.tweetWithCompletion(["status": tweetText.text]) { (tweet, error) -> () in
                print(self.tweetText.text)
                }
            /*(["status" : tweetText.text], success: { (User) -> () in
                var newTweet = self.tweet!
                }, failure: { (error: NSError) -> () in
                print("Tweet Error: \(error.localizedDescription)")
            })*/
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
