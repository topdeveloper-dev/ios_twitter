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
  var screenName: String?
  var retweeted: String?
  var prettyTimeStamp: String?

  init(dictionary: NSDictionary) {
    text = dictionary["text"] as? String
    retweetCount = dictionary["retweet_count"] as? Int ?? 0
    favoritesCount = dictionary["favourites_count"] as? Int ?? 0

    if let timeStampString = dictionary["created_at"] as? String {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timeStamp = formatter.dateFromString(timeStampString)
      prettyTimeStamp = Tweet.prettyTime(timeStamp!)
    }

    if let profileImageURL = dictionary["user"]?["profile_image_url"] as? String {
      avatarURL = NSURL(string: profileImageURL)
    }

    userName = dictionary["user"]?["name"] as? String
    if let sn = dictionary["user"]?["screen_name"] as? String {
      screenName = "@\(sn)"
    }

    let rtUserStartIndex = text!.startIndex.advancedBy(3)
    if let text = text where text.substringToIndex(rtUserStartIndex) == "RT " {
      if let colonRange = text.rangeOfString(":") {
        let colonEndIndex = colonRange.endIndex
        let colonStartIndex = colonRange.startIndex
        let rtUserName = text.substringWithRange(rtUserStartIndex..<colonStartIndex)
        self.text = text.substringWithRange(colonEndIndex..<text.endIndex)
        self.retweeted = "\(rtUserName) retweeted"
      }
    }
  }

  // modified version of
  // https://github.com/zemirco/swift-timeago/blob/master/swift-timeago/TimeAgo.swift
  class func prettyTime(date: NSDate) -> String {

    let calendar = NSCalendar.currentCalendar()
    let now = NSDate()
    let unitFlags: NSCalendarUnit = [.Second, .Minute, .Hour, .Day, .WeekOfYear, .Month, .Year]
    let components = calendar.components(unitFlags, fromDate: date, toDate: now, options: [])

    if components.year >= 1 || components.month > 1 || components.day > 1 {
      let formatter = NSDateFormatter()
      formatter.dateStyle = .ShortStyle
      formatter.timeStyle = .NoStyle
      return formatter.stringFromDate(date)
    }

    if components.hour >= 1 {
      return "\(components.hour)h"
    }

    if components.minute >= 1 {
      return "\(components.minute)m"
    }

    if components.second >= 1 {
      return "\(components.second)s"
    }

    return "now"

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
