//
//  RSIntroPage.swift
//  RSIntro
//
//  Created by Remi Santos on 22/01/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class RSIntroPage:UIView {
    
    var titleLabel:UILabel!
    var subtitleLabel:UILabel!
    var imageView:UIImageView!
    var bottomNextPage:UIButton!
    var intro:RSIntroView?
    
    var title:String? {
        didSet {
            titleLabel.text = title
        }
    }
    var subtitle:String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    var image:UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    init() {
        super.init(frame: CGRect.zeroRect)
    }
    init(introView:RSIntroView) {
        super.init(frame: introView.frame)
        intro = introView
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        self.clipsToBounds = false
        let margin = 40 as CGFloat
        
        imageView = UIImageView(frame: CGRect(x: 0, y: margin*2, width: self.frame.size.width, height: self.frame.size.height/2 - margin))
        imageView.contentMode = .ScaleAspectFit
        imageView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect(x: margin, y: self.center.y + margin*2, width: self.frame.size.width-margin*2, height: 80))
        titleLabel.text = title
        titleLabel.font = UIFont.systemFontOfSize(21)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        titleLabel.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel(frame: CGRect(x: margin, y: CGRectGetMaxY(titleLabel.frame) , width: self.frame.size.width-margin*2, height: 50))
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFontOfSize(13)
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.textAlignment = .Center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.addSubview(subtitleLabel)
        bottomNextPage = UIButton.buttonWithType(.Custom) as! UIButton
        bottomNextPage.frame = CGRect(x: 0, y: self.frame.size.height - margin*2, width: self.frame.size.width, height: margin)
        //        bottomNextPage.setTitle("Next", forState: .Normal)
        bottomNextPage.contentHorizontalAlignment = .Center
        bottomNextPage.addTarget(self, action: "nextPage:", forControlEvents: .TouchUpInside)
        self.addSubview(bottomNextPage)
    }
    
    func nextPage(sender:UIButton) {
        intro?.scrollToNexPage()
    }
}