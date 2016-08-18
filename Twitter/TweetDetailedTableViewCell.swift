//
//  TweetDetailedTableViewCell.swift
//  Twitter
//
//  Created by Gil Birman on 8/18/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class TweetDetailedTableViewCell: UITableViewCell {

  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var screenName: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var retweetView: UIView!
  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!

  var tweet: Tweet! {
    didSet {
      favoriteCountLabel.text = "\(tweet.favoritesCount)"
      retweetCountLabel.text = "\(tweet.retweetCount)"
      retweetLabel.text = tweet.retweeted
      retweetView.hidden = tweet.retweeted == nil
      userLabel.text = tweet.userName
      screenName.text = tweet.screenName
      tweetTextLabel.text = tweet.text
      dateLabel.text = tweet.prettyTimeStamp
      if let avatarURL = tweet.avatarURL {
        avatarImageView.setImageWithURL(avatarURL)
      } else {
        avatarImageView.image = nil
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
