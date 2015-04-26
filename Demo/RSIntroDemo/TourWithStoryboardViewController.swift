//
//  TourWithStoryboardViewController.swift
//  RSIntroDemo
//
//  Created by Remi Santos on 06/02/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class TourWithStoryboardViewController: UIViewController {

    var introView: RSIntroView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introView = RSIntroView(frame: self.view.frame)
        introView.verticalScroll = false
        introView.backgroundColor = UIColor(red:0.113725, green:0.600000, blue:0.964706, alpha:1.0)
        introView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(introView)
        let constraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[intro]|", options: nil, metrics: nil, views: ["intro":introView])
        let constraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[intro]|", options: nil, metrics: nil, views: ["intro":introView])
        self.view.addConstraints(constraintH + constraintV)
        
        //add pages using storyboard ids
        let storyboardIds = ["tourViewA", "tourViewB", "tourViewC"]
        var i = 0;
        for storyboardId in storyboardIds {
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)! as! UIViewController
            self.addChildViewController(controller)
            introView.addPageWithView(controller.view, atIndex: i)
            i++
        }
        
        //add some magic to your intro
        let pageWidth = self.view.frame.size.width
        let heart = RSIntroElement(frame: CGRect(x: view.center.x - 20, y: 60, width: 40, height: 40))
        let label = UILabel(frame: heart.bounds)
        label.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        label.text = "❤️"
        label.font = UIFont.systemFontOfSize(200)
        label.adjustsFontSizeToFitWidth = true
        heart.addSubview(label)
        introView.addElement(heart)

        heart.addKeyFrame(heart.frame, forTime: 0)
        heart.addKeyFrame(CGRect(x: 80, y: 20, width: 40, height: 40), forTime: pageWidth)
        heart.addKeyFrame(CGRect(x: 130, y: 20, width: 40, height: 40), forTime: pageWidth*2)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
