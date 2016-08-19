//
//  TweetViewController.swift
//  Twitter
//
//  Created by Gil Birman on 8/18/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var tweet: Tweet!

  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self

    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 300
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetDetailedTableViewCell") as! TweetDetailedTableViewCell

    cell.tweet = tweet
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func onReplyButton(sender: AnyObject) {
    print("reply")
  }

  @IBAction func onRetweetButton(sender: AnyObject) {
    print("retweet")
  }

  @IBAction func onLikeButton(sender: AnyObject) {
    print("like")
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
