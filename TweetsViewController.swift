//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Arnold Ballesteros on 2/21/16.
//  Copyright © 2016 Arnold Ballesteros. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!

    var tweets: [Tweet]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Table View Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
      
        TwittersClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            //self.tableView.reloadData()
            for tweet in tweets {
                print(tweet.text)
                
            }
            }) { (error: NSError) -> () in
                print("Tweet Error: \(error.localizedDescription)")
        }

        /*
        TwittersClient.sharedInstance.homeTimelineWithCompletion(nil) { (tweets, error) -> () in
            if (tweets != nil) {
                self.tweets = tweets
                self.tableView.reloadData()
            }
        }
        */
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwittersClient.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of Rows Initializing")
        if let tweets = self.tweets {
            print("Rows Initialized!")
            return tweets.count
        } else {
            print("Rows failed to initialize")
            return 0
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
        
        cell.tweet = tweets[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
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
