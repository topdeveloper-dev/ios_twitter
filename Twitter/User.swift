//
//  User.swift
//  Twitter
//
//  Created by Gil Birman on 8/15/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class User: NSObject {
  var name: String?
  var screenName: String?
  var avatarURL: NSURL?
  var bannerURL: NSURL?
  var tagline: String?
  var dictionary: NSDictionary?
  var followersCount: Int?
  var followingCount: Int?
  var tweetsCount: Int?

  init(dictionary: NSDictionary) {
    print(dictionary)
    name = dictionary["name"] as? String
    screenName = dictionary["screen_name"] as? String
    followersCount = dictionary["followers_count"] as? Int
    followingCount = dictionary["friends_count"] as? Int
    tweetsCount = dictionary["statuses_count"] as? Int

    self.dictionary = dictionary

    if let urlSring = dictionary["profile_image_url_https"] as? String {
      avatarURL = NSURL(string: urlSring)
    }

    if let urlString = dictionary["profile_banner_url"] as? String {
      bannerURL = NSURL(string: urlString)
    }

  }

  class var currentUser: User? {
    get {
      let defaults = NSUserDefaults.standardUserDefaults()
      guard let data = defaults.objectForKey("currentUser") as? NSData else { return nil }
      let dictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
      return User(dictionary: dictionary)
    }
    set(user) {
      let defaults = NSUserDefaults.standardUserDefaults()
      if let user = user {
        let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
        defaults.setObject(data, forKey: "currentUser")
      } else {
        defaults.setObject(nil, forKey: "currentUser")
      }
      defaults.synchronize()
    }
  }
}
