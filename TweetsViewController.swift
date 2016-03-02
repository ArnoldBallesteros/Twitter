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

    var tweets: [Tweet]?
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
        
//        TweetsCell.retweetButtonActivated.setImage(UIImage(named: "retweet-action.png") as UIImage, forState: .Normal)

        return cell
    }

    @IBAction func onTapDetail(sender: AnyObject) {
        self.performSegueWithIdentifier("profile", sender: nil)
    }
    
    
    
    @IBAction func onTapProfile(sender: AnyObject) {
        self.performSegueWithIdentifier("profile", sender: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      /* let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let tweetsDetailViewController = segue.destinationViewController as! TweetsDetailViewController
       
        tweetsDetailViewController.tweet = tweet
      */
        
        let chosenNavigationController = segue.destinationViewController
        
        if chosenNavigationController is TweetingViewController {
            let tweetingViewController = chosenNavigationController as! TweetingViewController
            tweetingViewController
            print("Pushed to Tweeting View")
        } else
        if chosenNavigationController is TweetsDetailViewController {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let tweetsDetailViewController = chosenNavigationController as! TweetsDetailViewController
            tweetsDetailViewController.tweet = tweet
            print("Pushed to Tweets Details")
        } else {
        if chosenNavigationController is DetailViewController {
            let detailViewController = chosenNavigationController as! DetailViewController
            
            print("Pushed to Profile/Detail VIew")
           
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            detailViewController.tweet = tweet
            }
        }
        
        
        
        
        /*
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        detailViewController.tweet = tweet
        */
        
        print("segue called")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
