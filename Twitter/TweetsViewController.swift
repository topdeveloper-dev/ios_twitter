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
    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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


  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
