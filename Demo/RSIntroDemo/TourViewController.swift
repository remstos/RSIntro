//
//  TourViewController.swift
//  RSIntroDemo
//
//  Created by Remi Santos on 06/02/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class TourViewController: UIViewController {

    var introView: RSIntroView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introView = RSIntroView(frame: self.view.frame)
        introView.verticalScroll = false
        introView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(introView)
        let constraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[intro]|", options: nil, metrics: nil, views: ["intro":introView])
        let constraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[intro]|", options: nil, metrics: nil, views: ["intro":introView])
        self.view.addConstraints(constraintH + constraintV)
        
        //add pages
        let storyboardIds = ["tourViewA", "tourViewB", "tourViewC"]
        var i = 0;
        for storyboardId in storyboardIds {
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId)! as UIViewController
            introView.addPageWithView(controller.view, atIndex: Float(i))
            i++
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
