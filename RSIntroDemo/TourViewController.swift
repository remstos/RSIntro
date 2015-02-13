//
//  TourViewController.swift
//  RSIntroDemo
//
//  Created by Remi Santos on 06/02/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class TourViewController: UIViewController {

    @IBOutlet weak var introView: RSIntroView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboardIds = ["tourViewA", "tourViewB"]
        
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
