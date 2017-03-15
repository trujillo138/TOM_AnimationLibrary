//
//  BackwardsAnimatingView.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 3/5/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class BackwardsAnimatingView: UIView, TTAnimation {

    //MARK: Variables
    
    private var backImageView: UIImageView?
    
    var delegate: TTAnimationDelegate?
    
    //MARK: Layout
    
    override func layoutSubviews() {
        backImageView?.frame = bounds
    }
    
    //MARK: Animation
    
    private func addAnimations() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.delegate?.finishedAnimatingView()
        }
        let backAnimation = CABasicAnimation(keyPath: TTAnimations.XPosition.rawValue)
        backAnimation.fromValue = 0
        backAnimation.toValue = -150
        backAnimation.duration = 1
        backAnimation.fillMode = kCAFillModeForwards
        backAnimation.isAdditive = true
        backImageView?.layer.add(backAnimation, forKey: "position animation")
        let fadeAnimation = CABasicAnimation(keyPath: TTAnimations.Opactiy.rawValue)
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        fadeAnimation.duration = 1
        fadeAnimation.fillMode = kCAFillModeForwards
        fadeAnimation.isAdditive = false
        backImageView?.layer.add(fadeAnimation, forKey: "opacity animation")
        CATransaction.commit()
    }
    
    //MARK: TTAnimation
    
    func stopAnimating() {
        backImageView?.layer.removeAllAnimations()
    }
    
    func beingAnimating() {
        addAnimations()
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        isOpaque = false
        contentMode = .redraw
        addUIImageView()
    }
    
    private func addUIImageView() {
        let backImg = UIImageView(image: UIImage(named: "arrow"))
        backImg.frame = bounds
        addSubview(backImg)
        backImageView = backImg
    }
}
