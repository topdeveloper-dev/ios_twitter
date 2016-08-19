//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Gil Birman on 8/18/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

  var originalLeftMargin: CGFloat!
  var menuViewController: UIViewController! {
    didSet {
      view.layoutIfNeeded()
      menuView.addSubview(menuViewController.view)
      print("xxxx")
    }
  }

  var contentViewController: UIViewController! {
    didSet(oldViewController) {
      view.layoutIfNeeded()

      if (oldViewController != nil) {
        oldViewController.willMoveToParentViewController(nil)
        oldViewController.view.removeFromSuperview()
      }
      contentViewController.willMoveToParentViewController(self)
      contentView.addSubview(contentViewController.view)
      contentViewController.didMoveToParentViewController(self)

      toggle(false)

    }
  }

  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var contentView: UIView!

  @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  func toggle(open: Bool) {
    UIView.animateWithDuration(0.3, animations: {
      self.leftMarginConstraint.constant = open ? self.view.frame.width - 50 : 0
      self.view.layoutIfNeeded()
    })
  }

  @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {

    let translation = sender.translationInView(view)
    let velocity = sender.velocityInView(view)

    if sender.state == .Began {
      originalLeftMargin = leftMarginConstraint.constant
    } else if sender.state == .Changed {
      leftMarginConstraint.constant = originalLeftMargin + translation.x
    } else if sender.state == .Ended {
      toggle(velocity.x > 0)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
