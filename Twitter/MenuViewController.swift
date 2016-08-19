//
//  MenuViewController.swift
//  Twitter
//
//  Created by Gil Birman on 8/18/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!

  let menuText = [
    0: "Home",
    1: "Mentions",
    2: "Profile",
  ]

  var viewControllers = [UIViewController]()
  var hamburgerViewController: HamburgerViewController!
  private var currentIndex: Int?

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self

    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    let tweetsViewController = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController")
    let mentionsViewController = storyboard.instantiateViewControllerWithIdentifier("MentionsNavigationController")
    let profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileNavigationController")

    viewControllers.append(tweetsViewController)
    viewControllers.append(mentionsViewController)
    viewControllers.append(profileViewController)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let row = indexPath.row
    print("select!", row)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    selectViewControllerAtIndex(row)
  }

  func selectViewControllerAtIndex(index: Int) {
    let vc = viewControllers[index]
    hamburgerViewController.contentViewController = vc
    currentIndex = index
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell")!
    cell.textLabel!.text = menuText[indexPath.row]
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
