//
//  TourViewController.swift
//  RSIntroDemo
//
//  Created by Remi Santos on 26/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class TourViewController: UIViewController {

    var introView: RSIntroView!
    override func viewDidLoad() {
        super.viewDidLoad()

        introView = RSIntroView(frame: self.view.frame)
        introView.verticalScroll = true
        introView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(introView)
        let constraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[intro]|", options: nil, metrics: nil, views: ["intro":introView])
        let constraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[intro]|", options: nil, metrics: nil, views: ["intro":introView])
        self.view.addConstraints(constraintH + constraintV)
        
        let page1 = RSIntroPage(introView: introView)
        page1.title = "Page 1"
        page1.nextButton.setImage(UIImage(named: "intro_next")!, forState: .Normal)
        page1.nextButton.hidden = false
        introView.addPageWithView(page1, atIndex:0)
        
        let page2 = RSIntroPage(introView: introView)
        page2.title = "Page 2"
        page2.nextButton.setImage(UIImage(named: "intro_next")!, forState: .Normal)
        page2.nextButton.hidden = false
        introView.addPageWithView(page2, atIndex:1)
        
        let page3 = RSIntroPage(introView: introView)
        page3.title = "Page 3"
        page3.nextButton.setImage(UIImage(named: "intro_next")!, forState: .Normal)
        page3.nextButton.hidden = false
        introView.addPageWithView(page3, atIndex:2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
