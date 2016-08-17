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
  var profileUrl: NSURL?
  var tagline: String?
  var dictionary: NSDictionary?

  init(dictionary: NSDictionary) {
    name = dictionary["name"] as? String
    screenName = dictionary["screen_name"] as? String
    self.dictionary = dictionary

    if let urlSring = dictionary["profile_image_url_https"] as? String {
      profileUrl = NSURL(string: urlSring)
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
