//
//  TweetsDetailViewController.swift
//  Twitter
//
//  Created by Arnold Ballesteros on 2/25/16.
//  Copyright © 2016 Arnold Ballesteros. All rights reserved.
//

import UIKit

class TweetsDetailViewController: UIViewController {

    @IBOutlet weak var tweetRetweetButton: UIButton!
    @IBOutlet weak var tweetFavoriteButton: UIButton!
    @IBOutlet weak var tweetFavoriteCountLabel: UILabel!
    @IBOutlet weak var tweetRetweetCountLabel: UILabel!
    @IBOutlet weak var tweetTimestampLabel: UILabel!
    @IBOutlet weak var tweetTweetLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweet: Tweet!
    
    let retweet = UIImage(named: "retweet-action.png") as UIImage!
    
    let retweetOn = UIImage(named: "retweet-action-on.png") as UIImage!
    
    let likeOn = UIImage(named: "like-action-on.png")! as UIImage
    
    let like = UIImage(named: "like-action.png") as UIImage!

    var retweetActive: Bool = false
    var likeActive: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTweetLabel.text = tweet.text as? String
        tweetTimestampLabel.text = tweet.createdAtString as! String
        tweetNameLabel.text = tweet.user!.name as? String
        profileImageView.setImageWithURL(tweet.user!.profileImageUrl!)
        tweetHandleLabel.text = "@\(tweet.user!.screenname!)" as? String
        tweetRetweetButton.setImage(retweet, forState: .Normal)
        tweetFavoriteButton.setImage(like, forState: .Normal)
        tweetRetweetCountLabel.text = "\(tweet.retweetCount as! Int)"
        tweetFavoriteCountLabel.text = "\(tweet.favoritesCount as! Int)"
        
        // Do any additional setup after loading the view.
        
    }

    @IBAction func FavoriteClicked(sender: UIButton) {
        print("Like Clicked")
        if retweetActive != true {
            sender.setImage(retweetOn, forState: UIControlState.Normal)
            retweetActive = true
        } else {
            sender.setImage(retweet, forState: UIControlState.Normal)
            retweetActive = false
        }
    }
    
    @IBAction func RetweetClicked(sender: UIButton) {
        print("Retweet Clicked")
        if likeActive != true {
            sender.setImage(likeOn, forState: UIControlState.Normal)
            likeActive = true
        } else {
            sender.setImage(like, forState: UIControlState.Normal)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender is UIButton ?	true : false {
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.tweet = tweet
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
	
    
}
