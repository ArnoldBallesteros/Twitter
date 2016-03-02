//
//  DetailViewController.swift
//  Twitter
//
//  Created by Arnold Ballesteros on 2/23/16.
//  Copyright © 2016 Arnold Ballesteros. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var TweetCount: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var tweet: Tweet!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
            nameLabel.text = tweet.user!.name as? String
            profileImage.setImageWithURL(tweet.user!.profileImageUrl!)
            handleLabel.text = "@\(tweet.user!.screenname!)" as? String
                
    }   

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
