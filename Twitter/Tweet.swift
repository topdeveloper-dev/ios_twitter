//
//  Tweet.swift
//  Twitter
//
//  Created by Gil Birman on 8/15/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class Tweet: NSObject {

  var text: String?
  var timeStamp: NSDate?
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  var avatarURL: NSURL?
  var userName: String?
  var retweeted: String?

  init(dictionary: NSDictionary) {
    text = dictionary["text"] as? String
    retweetCount = dictionary["retweet_count"] as? Int ?? 0
    favoritesCount = dictionary["favourites_count"] as? Int ?? 0

    if let timeStampString = dictionary["created_at"] as? String {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timeStamp = formatter.dateFromString(timeStampString)
    }

    if let profileImageURL = dictionary["user"]?["profile_image_url"] as? String {
      avatarURL = NSURL(string: profileImageURL)
    }

    userName = dictionary["user"]?["name"] as? String

    let rtUserStartIndex = text!.startIndex.advancedBy(3)
    if let text = text where text.substringToIndex(rtUserStartIndex) == "RT " {
      if let colonRange = text.rangeOfString(":") {
        let colonEndIndex = colonRange.endIndex
        let colonStartIndex = colonRange.startIndex.advancedBy(-1)
        let rtUserName = text.substringWithRange(rtUserStartIndex...colonStartIndex)
        self.text = text.substringWithRange(colonEndIndex...text.endIndex.advancedBy(-1))
        self.retweeted = "\(rtUserName) retweeted"
      }
    }
  }

  class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()

    for dictionary in dictionaries {
      let tweet = Tweet(dictionary: dictionary)
      tweets.append(tweet)
    }

    return tweets
  }
}
