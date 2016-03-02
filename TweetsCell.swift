//
//  TweetsCell.swift
//  Twitter
//
//  Created by Arnold Ballesteros on 2/21/16.
//  Copyright © 2016 Arnold Ballesteros. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {
    
    
   
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likingButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
  //  var tweetID: NSNumber?
    let retweetOn = UIImage(named: "retweet-action-on.png")! as UIImage
    
    let retweet = UIImage(named: "retweet-action.png") as UIImage!
    
    let likeOn = UIImage(named: "like-action-on.png")! as UIImage
    
    let like = UIImage(named: "like-action.png") as UIImage!
    
    
    var retweetActive: Bool = false
    var likeActive: Bool = false
   
    
    
    var tweet: Tweet! {
        didSet {
            print("Labels Printing")
            /*
            let tapGesture = UITapGestureRecognizer(target: self, action: "imageTapped")
            profileImageView.addGestureRecognizer(tapGesture)
            profileImageView.userInteractionEnabled = true
            */
            tweetsLabel.text = tweet.text as? String
            
            timeStampLabel.text = tweet.createdAtString as? String
            nameLabel.text = tweet.user!.name as? String
            profileImageView.setImageWithURL(tweet.user!.profileImageUrl!)
            handleLabel.text = "@\(tweet.user!.screenname!)" as? String
            retweetButton.setImage(retweet, forState: .Normal)
            likingButton.setImage(like, forState: .Normal)
          
            
   //         self.retweetButtonActivated.setImage(retweet, forState: .Normal)
            
        }
    }
  /*
    func imageTapped(gesture: UITapGestureRecognizer, segue: UIStoryboardSegue, sender: AnyObject?, vc: TweetsViewController) {
        
        if segue.identifier == "profileSegue" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            let cell = sender as! UITableViewCell
            let indexPath = vc.tableView.indexPathForCell(cell)
            let tweet = vc.tweets![indexPath!.row]
            
            detailViewController.tweet = tweet
        }

        
    }
    */
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //Rounded Corners Profile
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width

    }
    
    
    @IBAction func retweetButtonClicked(sender: UIButton) {
        print("Retweet Clicked")
        
        if retweetActive != true {
            sender.setImage(retweetOn, forState: UIControlState.Normal)
            retweetActive = true
        } else {
            sender.setImage(retweet, forState: UIControlState.Normal)
            retweetActive = false
        }
        
        
        
    }
    
    @IBAction func likingButtonClicked(sender: UIButton) {
        print("Like Clicked")
        if likeActive != true {
            sender.setImage(likeOn, forState: UIControlState.Normal)
            likeActive = true
        } else {
            sender.setImage(like, forState: UIControlState.Normal)
        }

    }
           
    


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


