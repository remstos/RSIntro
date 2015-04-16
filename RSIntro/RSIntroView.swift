//
//  RSIntroView.swift
//  RSIntro
//
//  Created by Remi Santos on 15/01/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit


@objc protocol RSIntroViewDelegate {
//    optional func introViewPageWillAppear(page:Int)
    optional func introViewPageDidAppear(page:Int)
    optional func introViewPageWillDisappear(page:Int)
}

class RSIntroView: UIView,UIScrollViewDelegate {

    
    var scrollView:UIScrollView!
    var contentView:UIView!
    var contentHeight:NSLayoutConstraint!
    var contentWidth:NSLayoutConstraint!
    
    var verticalScroll:Bool = true
    var currentPage = 0 as Int
    private var numberOfPages = 0
    var delegate:RSIntroViewDelegate?
    
    var pagingEnabled:Bool = true {
        didSet {
            scrollView.pagingEnabled = pagingEnabled
        }
    }
    var elementViews:[RSIntroElement] = []

    init() {
        super.init(frame:CGRect.zeroRect)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        scrollView = UIScrollView(frame: self.frame)
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.delegate = self
        scrollView.pagingEnabled = pagingEnabled
        self.addSubview(scrollView)
        let scrollH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: nil, metrics: nil, views: ["scrollView":scrollView])
        let scrollV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: nil, metrics: nil, views: ["scrollView":scrollView])
        self.addConstraints(scrollH+scrollV)
        
        contentView = UIView()
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.addSubview(contentView)
        let contentH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[content]|", options: nil, metrics: nil, views: ["content":contentView])
        let contentV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[content]|", options: nil, metrics: nil, views: ["content":contentView])
        contentWidth = NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1, constant:0)
        contentHeight = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: 1, constant:0)
        scrollView.addConstraints([contentWidth,contentHeight] + contentH + contentV)
    }
    
    func addElement(elementView:RSIntroElement) {
        elementViews.append(elementView)
        self.addSubview(elementView)
    }
    
    func addPageWithView(view:UIView, atIndex index:Float) {
        numberOfPages++
        view.frame = scrollView.frame
        scrollView.addSubview(view)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        let w = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1, constant: 0)
        let h = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: 1, constant:0)
        scrollView.addConstraints([w,h])
        if verticalScroll {
            let t = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1, constant: scrollView.frame.size.height * CGFloat(index))
            scrollView.addConstraint(t)
        } else {
            let l = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: scrollView, attribute: .Leading, multiplier: 1, constant: scrollView.frame.size.width * CGFloat(index))
            scrollView.addConstraint(l)
        }
        self.updateScrollViewContentSize()

    }
    
    func updateScrollViewContentSize(){
        if verticalScroll {
            scrollView.removeConstraint(contentHeight)
            contentHeight = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: CGFloat(numberOfPages), constant:0)
            scrollView.addConstraint(contentHeight)
        } else {
            scrollView.removeConstraint(contentWidth)
            contentWidth = NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: CGFloat(numberOfPages), constant:0)
            scrollView.addConstraint(contentWidth)
        }
    }
    func addPageWithTitle(title:String?, subtitle:String?, image:UIImage?, atIndex:Float) {
        let view = RSIntroPage(frame: self.frame)
        view.title = title
        view.subtitle = subtitle
        view.image = image
        self.addPageWithView(view, atIndex: atIndex)
    }
    
    func scrollToNexPage(){
        if self.currentPage >= numberOfPages-1 {
            return
        }
        var offset = scrollView.contentOffset
        if verticalScroll {
            offset.y += self.frame.size.height
        } else {
            offset.x += self.frame.size.width
        }
        self.scrollView.setContentOffset(offset, animated: true)
    }
    
    func animateElementsForTime(time:CGFloat) {
        
        for element in elementViews {
            if element.times.count < 2 {
                continue
            }
            
            var interval = element.getIntervalFramesForTime(time)
            if interval.start == interval.end {
                element.frame = CGRectApplyAffineTransform(interval.start.frame, element.transform)
            } else {
                element.frame = CGRectApplyAffineTransform(element.getFrameWithInterval(interval, forTime: time), element.transform)
            }
            
            if element.timeHandler != nil {
                element.timeHandler!(time:time, element:element)
            }
        }
    }
    
    //// MARK: - ScrollView delegate
    func getPageWithOffset(offset:CGPoint) -> Int {
        return verticalScroll ? Int(offset.y/self.frame.size.height) : Int(offset.x/self.frame.size.width)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        var time = verticalScroll ? offset.y:offset.x
        animateElementsForTime(time)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        currentPage = getPageWithOffset(offset)
        self.delegate?.introViewPageDidAppear?(currentPage)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.delegate?.introViewPageWillDisappear?(currentPage)
    }
}





