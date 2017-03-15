//
//  CyclingAnimatingView.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 3/5/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class CyclingAnimatingView: UIView, TTAnimation {
    
    //MARK: Variables
    
    private var cycleImage: UIImageView?
    
    var delegate: TTAnimationDelegate?
    
    //MARK: Layout
    
    override func layoutSubviews() {
        cycleImage?.frame = bounds
    }
    
    //MARK: Animation
    
    private func addAnimations() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.delegate?.finishedAnimatingView()
        }
        let rotationAnimation = CABasicAnimation(keyPath: TTAnimations.ZRotation.rawValue)
        rotationAnimation.fromValue = 6 * M_PI
        rotationAnimation.toValue = 0.0
        rotationAnimation.duration = 5
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.isAdditive = true
        cycleImage?.layer.add(rotationAnimation, forKey: "rotating animation")
        CATransaction.commit()
    }
    
    //MARK: TTAnimation
    
    func stopAnimating() {
        cycleImage?.layer.removeAllAnimations()
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
        let cycleImg = UIImageView(image: UIImage(named: "cycle"))
        cycleImg.frame = bounds
        addSubview(cycleImg)
        cycleImage = cycleImg
    }
    
}
