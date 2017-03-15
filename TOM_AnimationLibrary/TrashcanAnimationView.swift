//
//  TrashcanAnimationView.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 3/12/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class TrashcanAnimationView: UIView, TTAnimation {
    
    //MARK: Variables
    
    var delegate: TTAnimationDelegate?
    
    private var lidImageView: UIImageView?
    
    private var canImageView: UIImageView?
    
    //MARK: Animation
    
    private func addAnimations() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.addSecondAnimation()
        }
        let lidMovementAnimation = CAKeyframeAnimation(keyPath: TTAnimations.YPosition.rawValue)
        lidMovementAnimation.values = [0.0, -50, -50, -50, -50, 0.0]
        lidMovementAnimation.duration = 0.6
        lidMovementAnimation.fillMode = kCAFillModeForwards
        lidMovementAnimation.isAdditive = true
        let shakingLidAnimation = CAKeyframeAnimation(keyPath: TTAnimations.ZRotation.rawValue)
        shakingLidAnimation.values = [0.0, 0.0, M_PI_4 / 2, -M_PI_4 / 2, M_PI_4 / 2, 0.0]
        shakingLidAnimation.duration = 0.6
        shakingLidAnimation.fillMode = kCAFillModeForwards
        shakingLidAnimation.isAdditive = true
        lidImageView?.layer.add(lidMovementAnimation, forKey: "Lid movement")
        lidImageView?.layer.add(shakingLidAnimation, forKey: "Lid Shaking")
        CATransaction.commit()
    }
    
    private func addSecondAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.delegate?.finishedAnimatingView()
        }
        let miniMovementAnimation = CABasicAnimation(keyPath: TTAnimations.YPosition.rawValue)
        miniMovementAnimation.fromValue = 0.0
        miniMovementAnimation.toValue = -10
        miniMovementAnimation.fillMode = kCAFillModeForwards
        miniMovementAnimation.isAdditive = true
        miniMovementAnimation.duration = 0.1
        lidImageView?.layer.add(miniMovementAnimation, forKey: "Landing jump")
        canImageView?.layer.add(miniMovementAnimation, forKey: "Landing jump")
        CATransaction.commit()
    }
    
    //MARK: TTAnimation
    
    func stopAnimating() {
        lidImageView?.layer.removeAllAnimations()
        canImageView?.layer.removeAllAnimations()
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
        let lidFraction:CGFloat = 0.25
        let distBetwwenLidCan:CGFloat = 0.01
        let lidImg = UIImageView(image: UIImage(named: "Trash can lid"))
        lidImg.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height * lidFraction)
        addSubview(lidImg)
        lidImageView = lidImg
        let canFraction = 1.0 - distBetwwenLidCan - lidFraction
        let canImg = UIImageView(image: UIImage(named: "trash can"))
        canImg.frame = CGRect(x: 0.0, y: (1.0 - canFraction) * bounds.height, width: bounds.width, height: bounds.height * canFraction)
        addSubview(canImg)
        canImageView = canImg
    }
}
