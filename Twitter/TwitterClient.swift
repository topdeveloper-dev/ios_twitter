//
//  TwitterClient.swift
//  Twitter
//
//  Created by Gil Birman on 8/15/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {
  static let userDidLogoutNotification = "UserDidLogout"
  static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "ZPjlT8RHyGtWxumSUIDegUGiK", consumerSecret: "lyLpHABRt7cSWNJ6mv1gyWJnFs0ty9lryFBIR8Af7gO7rVRapx")

  var loginSuccess: (() -> ())?
  var loginFailure: ((NSError) -> ())?

  func tweet(status: String, success: () -> (), failure: (NSError) -> ()) {
    let parameters = [ "status": status ]
    POST("1.1/statuses/update.json", parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      success()
    }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
      print("error", error)
    })
  }

  func userTimeline(screenName screenName: String, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
    let parameters = [ "screen_name": screenName ]
    GET("1.1/statuses/user_timeline.json", parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
      success(tweets)
      }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        print("error", error)
    })
  }

  func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
    GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
      success(tweets)
      }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        print("error", error)
    })
  }

  func userCredentials(success: (User) -> (), failure: (NSError) -> ()) {
    GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let user = User(dictionary: response as! NSDictionary) // todo
      success(user)
    }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
      failure(error)
    })
  }

  func getUser(screenName screenName: String, success: (User) -> (), failure: (NSError) -> ()) {
    let parameters = [ "screen_name": screenName ]
    GET("1.1/users/show.json", parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
      let user = User(dictionary: response as! NSDictionary) // todo
      success(user)
      }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        failure(error)
    })
  }

  func login(success: () -> (), failure: (NSError) -> ()) {
    let twitterClient = TwitterClient.sharedInstance
    let callbackURL = NSURL(string: "twitterdemo://oauth")

    loginSuccess = success
    loginFailure = failure

    twitterClient.deauthorize()
    twitterClient.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: callbackURL, scope: nil, success: { (requestToken: BDBOAuth1Credential!) in
      let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
      UIApplication.sharedApplication().openURL(url!)
      //      loginSuccess()
    }) { (error: NSError!) in
      print(error.localizedDescription)
      self.loginFailure?(error)
    }
  }

  func handleOpenUrl(url: NSURL) {
    let twitterClient = TwitterClient.sharedInstance
    let requestToken = BDBOAuth1Credential(queryString: url.query)

    twitterClient.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
      print("yay I got access token")

      self.userCredentials({ (user: User) in
        User.currentUser = user
        self.loginSuccess?()
      }, failure: { (error: NSError) in
        self.loginFailure?(error)
      })

    }) { (error: NSError!) in
      print("error", error.localizedDescription)
      self.loginFailure?(error)
    }
  }

  func logout() {
    User.currentUser = nil
    deauthorize()

    NSNotificationCenter.defaultCenter().postNotificationName(TwitterClient.userDidLogoutNotification, object: nil)
  }
  
}
