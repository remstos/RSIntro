//
//  ViewController.swift
//  RSIntroDemo
//
//  Created by Remi Santos on 23/01/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

let A4Width = 200 as CGFloat
let A4Height = 283 as CGFloat

class OrigamiViewController: UIViewController,RSIntroViewDelegate {

    var introView:RSIntroView!
    
    var rectA:RSIntroElement!
    var rectC:Triangle!
    var rectD:Triangle!
    var rectE:Triangle!
    var rectF:Triangle!
    var rectG:RSIntroElement!
    var rectH:RSIntroElement!
    var slideView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
        let bg = UIImageView(frame: self.view.frame)
        bg.image = UIImage(named:"origami_bg")
        bg.contentMode = .ScaleAspectFill
        bg.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.view.addSubview(bg)
        
        buildIntro()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        slideView.layer.removeAllAnimations()
        let slideAnim = CAKeyframeAnimation(keyPath: "transform.translation.y")
        slideAnim.values = [170, 120, 70, 20]
        let alphaAnim = CAKeyframeAnimation(keyPath: "opacity")
        alphaAnim.values = [0, 1, 1, 0]
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [0.6, 0.8, 0.8, 0.6]
        var groupAnim = CAAnimationGroup()
        groupAnim.animations = [slideAnim, alphaAnim, scaleAnim]
        groupAnim.duration = 1.5
        groupAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        groupAnim.repeatCount = Float.infinity
        slideView.layer.addAnimation(groupAnim, forKey: "slide")
    }
    func closeButtonClicked(sender:UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func buildIntro() {
        introView = RSIntroView(frame: self.view.frame)
        introView.backgroundColor = UIColor.clearColor()
        introView.delegate = self
        self.view.addSubview(introView)
        let page1 = RSIntroPage(introView: introView)
        page1.title = "First, take a piece of paper. A4 should be fine!"
        page1.nextButton.setImage(UIImage(named: "intro_next")!, forState: .Normal)
        introView.addPageWithView(page1, atIndex:0)
        slideView = UIImageView(image: UIImage(named:"touch"))
        page1.addSubview(slideView)
        slideView.center = page1.center
        
        let page2 = RSIntroPage(introView: introView)
        page2.title = "Fold it like this. Pretty easy right?"
        page2.subtitle = "Sorry if you're stock on this step..."
        page2.nextButton.setImage(UIImage(named: "intro_next")!, forState: .Normal)
        page2.nextButton.hidden = false
        introView.addPageWithView(page2, atIndex:1)
        
        let page3 = RSIntroPage(introView: introView)
        page3.title = "Take the corners and fold them like that. Still easy!"
        page3.nextButton.setImage(UIImage(named: "intro_next")!, forState: .Normal)
        page3.nextButton.hidden = false
        introView.addPageWithView(page3, atIndex:2)
        
        let page4 = RSIntroPage(introView: introView)
        page4.title = "Final step, do this in below and behind. And you're done!"
        introView.addPageWithView(page4, atIndex:3)
        
        let pageHeight = self.view.frame.size.height
        self.view.backgroundColor = UIColor.lightGrayColor()
        rectA = RSIntroElement(frame: CGRect(x: 0, y: 0, width: A4Width, height: A4Height/2))
        rectA.backgroundColor = UIColor.whiteColor()
        rectA.shadowify()
        rectA.center = self.view.center
        rectA.center.y -= 50
        rectA.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        rectA.addKeyFrame(rectA.frame, forTime: 0)
        rectA.addKeyFrame(rectA.frame, forTime: pageHeight)
        rectA.addKeyFrame(rectA.frame, forTime: pageHeight*3)
        rectA.addKeyFrame(CGRectOffset(rectA.frame, 0, -400), forTime: pageHeight*4)
        
        rectA.layer.shadowOffset = CGSize(width: 1, height: -1)
        rectA.addTimeHandlerWithBlock { (time, element) -> Void in
            if(time <= pageHeight) {
                element.hidden = false
                var flipV = CATransform3DIdentity
                flipV.m34 = 1 / -750
                flipV = CATransform3DRotate(flipV, degree2radian(-180*(time/pageHeight)), 1, 0, 0)
                self.rectA.layer.transform = flipV
            } else { //if time < pageHeight{
                element.hidden = true
            }
        }
        
        introView.addElement(rectA)
        
        rectC = Triangle(frame: CGRect(x: CGRectGetMinX(rectA.frame), y: CGRectGetMaxY(rectA.frame), width: A4Width/2, height: A4Width/2), orientation:.TopLeft)
        rectC.backgroundColor = UIColor.clearColor()
        rectC.addKeyFrame(rectC.frame, forTime: 0)
        rectC.addKeyFrame(rectC.frame, forTime: pageHeight*2)
        rectC.addKeyFrame(rectC.frame, forTime: pageHeight*3)
        rectC.addKeyFrame(CGRectOffset(rectC.frame, 0, -400), forTime: pageHeight*4)
        rectC.shadowify()
        introView.addElement(rectC)
        
        rectD = Triangle(frame: CGRect(x: CGRectGetMidX(rectA.frame), y: CGRectGetMaxY(rectA.frame), width: A4Width/2, height: A4Width/2), orientation:.TopRight)
        rectD.backgroundColor = UIColor.clearColor()
        rectD.shadowify()
        rectD.addKeyFrame(rectD.frame, forTime: 0)
        rectD.addKeyFrame(rectD.frame, forTime: pageHeight*2)
        rectD.addKeyFrame(rectD.frame, forTime: pageHeight*3)
        rectD.addKeyFrame(CGRectOffset(rectD.frame, 0, -400), forTime: pageHeight*4)
        rectD.addTimeHandlerWithBlock { (time, element) -> Void in
            if(time >= pageHeight && time <= pageHeight*3) {
                var identity = CATransform3DIdentity
                identity.m34 = 1 / -750
                
                let percent = (time - pageHeight) / pageHeight
                var flipL = CATransform3DRotate(identity, degree2radian(max(-178,-150*percent)), 1, -1, 0)
                self.rectC.layer.transform = flipL
                let flipR = CATransform3DRotate(identity, degree2radian(max(-178,-150*percent)), 1, 1, 0)
                self.rectD.layer.transform = flipR
            }
        }
        introView.addElement(rectD)
        
        rectE = Triangle(frame: CGRect(x: CGRectGetMinX(rectA.frame), y: CGRectGetMaxY(rectA.frame), width: A4Width/2, height: A4Width/2), orientation:.BottomRight)
        rectE.backgroundColor = UIColor.clearColor()
        rectE.addKeyFrame(rectE.frame, forTime: 0)
        rectE.addKeyFrame(rectE.frame, forTime: pageHeight*2)
        rectE.addKeyFrame(rectE.frame, forTime: pageHeight*3)
        rectE.addKeyFrame(CGRectOffset(rectE.frame, 0, -400), forTime: pageHeight*4)
        introView.addElement(rectE)
        rectF = Triangle(frame: CGRect(x: CGRectGetMidX(rectA.frame), y: CGRectGetMaxY(rectA.frame), width: A4Width/2, height: A4Width/2), orientation:.BottomLeft)
        rectF.backgroundColor = UIColor.clearColor()
        rectF.addKeyFrame(rectF.frame, forTime: 0)
        rectF.addKeyFrame(rectF.frame, forTime: pageHeight)
        rectF.addKeyFrame(rectF.frame, forTime: pageHeight*2)
        rectF.addKeyFrame(rectF.frame, forTime: pageHeight*3)
        rectF.addKeyFrame(CGRectOffset(rectF.frame, 0, -400), forTime: pageHeight*4)
        introView.addElement(rectF)
        
        
        rectG = RSIntroElement(frame: CGRect(x: CGRectGetMinX(rectA.frame), y: CGRectGetMaxY(rectC.frame), width: A4Width, height: A4Height/2 - A4Width/2))
        rectG.backgroundColor = UIColor.whiteColor()
        rectG.shadowify()
        rectG.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        rectG.frame.origin.y = CGRectGetMaxY(rectC.frame)
        rectG.addKeyFrame(rectG.frame, forTime: 0)
        rectG.addKeyFrame(rectG.frame, forTime: pageHeight*3)
        rectG.addKeyFrame(rectG.frame, forTime: pageHeight*3)
        rectG.addKeyFrame(CGRectOffset(rectG.frame, 0, -400), forTime: pageHeight*4)
        introView.addElement(rectG)
        
        rectH = RSIntroElement(frame: rectG.frame)
        rectH.backgroundColor = UIColor.whiteColor()
        rectH.shadowify()
        rectH.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        rectH.frame.origin.y = CGRectGetMaxY(rectC.frame)
        rectH.addKeyFrame(rectH.frame, forTime: 0)
        rectH.addKeyFrame(rectH.frame, forTime: pageHeight*3)
        rectH.addKeyFrame(rectH.frame, forTime: pageHeight*3)
        rectH.addKeyFrame(CGRectOffset(rectH.frame, 0, -400), forTime: pageHeight*4)
        rectH.addTimeHandlerWithBlock { (time, element) -> Void in
            if(time > pageHeight*2 && time <= pageHeight*3) {
                let percent = (time - pageHeight*2) / pageHeight
                var identity = CATransform3DIdentity
                identity.m34 = 1 / -750
                let flipG = CATransform3DRotate(identity, degree2radian(140*percent), 1, 0, 0)
                self.rectG.layer.transform = flipG
                let flipH = CATransform3DRotate(identity, degree2radian(-160*percent), 1, 0, 0)
                self.rectH.layer.transform = flipH
            }
        }
        introView.addElement(rectH)
        
        introView.bringSubviewToFront(rectH)
        introView.bringSubviewToFront(rectG)
        introView.bringSubviewToFront(rectE)
        introView.bringSubviewToFront(rectF)
        introView.bringSubviewToFront(rectA)
    }
    func introViewPageDidAppear(page: Int) {
        
    }
    
}

func degree2radian(a:CGFloat)->CGFloat {
    let b = CGFloat(M_PI) * a/180
    return b
}