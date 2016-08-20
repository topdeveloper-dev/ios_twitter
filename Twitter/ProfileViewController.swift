//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Gil Birman on 8/15/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!

  var tweets: [Tweet]?
  var headerView: ProfileHeaderView!
  var userScreenName: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    headerView = NSBundle.mainBundle().loadNibNamed("ProfileHeader", owner: nil, options: nil)[0] as! ProfileHeaderView

    if userScreenName != nil {
      headerView.userScreenName = userScreenName
    } else {
      headerView.user = User.currentUser
    }

    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(TweetsViewController.refreshControlAction), forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)

    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension

    refreshTweets()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func refreshTweets(refreshControl: UIRefreshControl?) {
    let success = { (tweets: [Tweet]) in
      self.tweets = tweets
      self.tableView.reloadData()
      refreshControl?.endRefreshing()
    }
    let failure = { (error: NSError) in
      print("error", error)
      refreshControl?.endRefreshing()
    }

    if let userScreenName = userScreenName {
      TwitterClient.sharedInstance.userTimeline(
        screenName: userScreenName,
        success: success,
        failure: failure)
    } else {
      TwitterClient.sharedInstance.homeTimeline(success, failure: failure)
    }
  }

  func refreshTweets() {
    refreshTweets(nil)
  }

  func refreshControlAction(refreshControl: UIRefreshControl) {
    refreshTweets(refreshControl)
  }

  @IBAction func onLogoutButton(sender: AnyObject) {
    TwitterClient.sharedInstance.logout()
  }


  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets?.count ?? 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell") as! TweetTableViewCell

    cell.tweet = tweets![indexPath.row]
    cell.navigationController = navigationController
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let tweetViewController = storyboard.instantiateViewControllerWithIdentifier("TweetViewController") as! TweetViewController
    tweetViewController.tweet = tweets![indexPath.row]

    navigationController?.pushViewController(tweetViewController, animated: true)
  }

  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return headerView

  }

  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return headerView.frame.height
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let vc = segue.destinationViewController as? TweetViewController {
      let cell = sender as! TweetTableViewCell
      let indexPath = tableView.indexPathForCell(cell)!
      vc.tweet = tweets![indexPath.row]
    }
  }
  
}
