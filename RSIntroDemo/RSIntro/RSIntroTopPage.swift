//
//  RSIntroTopPage.swift
//  RSIntro
//
//  Created by Remi Santos on 22/01/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class RSIntroTopPage:UIView {
    
    var titleLabel:UILabel!
    var imageView:UIImageView!
    var nextPageButton:UIButton!
    var intro:RSIntroView?
    
    var title:String? {
        didSet {
            titleLabel.text = title
        }
    }
    var image:UIImage? {
        didSet {
            imageView.image = image
        }
    }
    init(introView:RSIntroView) {
        super.init(frame: introView.frame)
        intro = introView
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        self.clipsToBounds = false
        let margin = 40 as CGFloat
        
        titleLabel = UILabel(frame: CGRect(x: margin, y: margin, width: self.frame.size.width-margin*2, height: 100))
        titleLabel.font = UIFont(name: "Avenir-Roman", size: 22)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        titleLabel.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        titleLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(titleLabel)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height/2))
        imageView.contentMode = .ScaleAspectFit
        imageView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        imageView.center = self.center
        self.addSubview(imageView)
                
        nextPageButton = UIButton.buttonWithType(.Custom) as UIButton
        if (intro?.verticalScroll != nil) {
            nextPageButton.frame = CGRect(x: 0, y: self.frame.size.height - margin*2, width: self.frame.size.width, height: margin)
        } else {
//            nextPageButton.frame = CGRect(x: 0, y: self.frame.size.height - margin*2, width: self.frame.size.width, height: margin)
        }
        nextPageButton.contentHorizontalAlignment = .Center
        nextPageButton.addTarget(self, action: "nextPage:", forControlEvents: .TouchUpInside)
        self.addSubview(nextPageButton)
    }
    
    func nextPage(sender:UIButton) {
        intro?.scrollToNexPage()
    }
}