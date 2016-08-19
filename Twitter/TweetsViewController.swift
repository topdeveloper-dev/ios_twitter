//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Gil Birman on 8/15/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!

  var tweets: [Tweet]?

  override func viewDidLoad() {
    super.viewDidLoad()

    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(TweetsViewController.refreshControlAction), forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)

    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension

    TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) in
      print(tweets)
      self.tweets = tweets
      self.tableView.reloadData()
    }) { (error: NSError) in
      print("error", error)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func refreshControlAction(refreshControl: UIRefreshControl) {
    TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) in
      self.tweets = tweets
      self.tableView.reloadData()
      refreshControl.endRefreshing()
    }) { (error: NSError) in
      print("error", error)
      refreshControl.endRefreshing()
    }
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
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
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
