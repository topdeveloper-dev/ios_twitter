//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Gil Birman on 8/17/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

  @IBOutlet weak var retweetView: UIView!
  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var retweetedLabel: UILabel!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!

  var tweet: Tweet! {
    didSet {
      retweetLabel.text = tweet.retweeted
      retweetView.hidden = tweet.retweeted == nil
      userLabel.text = tweet.userName
      tweetTextLabel.text = tweet.text
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
