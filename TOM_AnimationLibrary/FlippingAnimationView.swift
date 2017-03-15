//
//  FlippingAnimationView.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 3/9/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class FlippingAnimationView: UIView, TTAnimation {
    
    //MARK: Variables
    
    private var coinImageView: UIImageView?
    
    var delegate: TTAnimationDelegate?
    
    //MARK: Layout
    
    override func layoutSubviews() {
        coinImageView?.frame = bounds
    }
    
    //MARK: Animation
    
    private func addAnimations() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.delegate?.finishedAnimatingView()
        }
        let flipAnimationStages = CAKeyframeAnimation(keyPath: TTAnimations.YPosition.rawValue)
        flipAnimationStages.values = [0.0, -200, 0.0]
        flipAnimationStages.duration = 1.0
        flipAnimationStages.fillMode = kCAFillModeForwards
        flipAnimationStages.isAdditive = true
        let rotationAnimation = CABasicAnimation(keyPath: TTAnimations.XRotation.rawValue)
        rotationAnimation.fromValue = M_PI * 4
        rotationAnimation.toValue = 0.0
        rotationAnimation.duration = 1.0
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.isAdditive = true
        coinImageView?.layer.add(flipAnimationStages, forKey: "Flipping animation stages")
        coinImageView?.layer.add(rotationAnimation, forKey: "Rotating animation")
        CATransaction.commit()
    }
    
    //MARK: TTAnimation
    
    func stopAnimating() {
        coinImageView?.layer.removeAllAnimations()
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
        let cycleImg = UIImageView(image: UIImage(named: "coin"))
        cycleImg.frame = bounds
        addSubview(cycleImg)
        coinImageView = cycleImg
    }
    
}
