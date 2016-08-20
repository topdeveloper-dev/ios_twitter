//
//  ProfileHeaderView.swift
//  Twitter
//
//  Created by Gil Birman on 8/19/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

  @IBOutlet weak var followersCountLabel: UILabel!
  @IBOutlet weak var followingCountLabel: UILabel!
  @IBOutlet weak var tweetsCountLabel: UILabel!
  @IBOutlet weak var followersCountView: UIView!
  @IBOutlet weak var followingCountView: UIView!
  @IBOutlet weak var tweetsCountView: UIView!
  @IBOutlet weak var bannerImageView: UIImageView!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!

  var userScreenName: String? {
    didSet {
      setup()
    }
  }

  var user: User? {
    didSet {
      setup()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

  }

  func setup() {
    if let userScreenName = userScreenName {
      TwitterClient.sharedInstance.getUser(screenName: userScreenName, success: { (user: User) in
        self.populateWithUser(user)
        }, failure: { (error: NSError) in
          print(error)
      });
    } else {
      populateWithUser(User.currentUser!)
    }
  }

  func populateWithUser(user: User) {
    backgroundColor = UIColor.blackColor()

    let grey = UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor
    tweetsCountView.layer.borderWidth = 1
    tweetsCountView.layer.borderColor = grey
    followersCountView.layer.borderWidth = 1
    followersCountView.layer.borderColor = grey
    followingCountView.layer.borderWidth = 1
    followingCountView.layer.borderColor = grey

    userLabel.text = user.name
    screenNameLabel.text = user.screenName
    followingCountLabel.text = optionalIntToString(user.followingCount)
    followersCountLabel.text = optionalIntToString(user.followersCount)
    tweetsCountLabel.text = optionalIntToString(user.tweetsCount)

    if let avatarURL = user.avatarURL {
      avatarImageView.setImageWithURL(avatarURL)
      avatarImageView.layer.cornerRadius = 5;
      avatarImageView.layer.masksToBounds = true;
    }
    if let bannerURL = user.bannerURL {
      bannerImageView.setImageWithURL(bannerURL)
    }
  }

  func optionalIntToString(i: Int?) -> String {
    guard let v = i else { return "" }
    return "\(v)"
  }

  /*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func drawRect(rect: CGRect) {
   // Drawing code
   }
   */

}
