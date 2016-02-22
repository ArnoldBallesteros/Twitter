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
    var refreshControl = UIRefreshControl!()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Logo on Navigation Bar
        let logo = UIImage(named: "TwitterLogoWhite.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        // Do any additional setup after loading the view.
        //Table View Setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        TwittersClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
           
            for tweet in tweets {
                print(tweet.text)
                
            }
            }) { (error: NSError) -> () in
                print("Tweet Error: \(error.localizedDescription)")
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwittersClient.sharedInstance.logout()
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        
        refreshControl.endRefreshing()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of Rows Initializing")
        if tweets != nil {
            print("Rows Initialized!")
            return tweets!.count
        } else {
            print("Rows failed to initialize")
            return 0
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsCell", forIndexPath: indexPath) as! TweetsCell
        
        cell.tweet = tweets![indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }


    @IBAction func retweetButtonClicked(sender: AnyObject) {
        
                print("Retweet button triggered")
        
                var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        
                var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        
                let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetsCell
        
        
        
                let tweet = tweets![indexPath.row]
        
                let tweetID = tweet.id
        
                TwittersClient.sharedInstance.retweet(["id": tweetID!]) { (tweet, error) -> () in
        
                    if (tweet != nil) {
                        print("Retweet Acheived")
        
                        var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        
                    }
                    else {
                        print("Retweet Error")
                    }
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
