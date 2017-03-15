//
//  StartingTruck.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 3/12/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class StartingTruckAnimationView: UIView, TTAnimation {
    
    //MARK: Variables
    
    var delegate: TTAnimationDelegate?
    
    private var truckImageView: UIImageView?
    
    //MARK: Animation
    
    private func addAnimations() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.addSecondAnimation()
        }
        let shakingLidAnimation = CAKeyframeAnimation(keyPath: TTAnimations.ZRotation.rawValue)
        shakingLidAnimation.values = [0.0, M_PI_4 / 4, -M_PI_4 / 4, M_PI_4 / 4, -M_PI_4 / 4, M_PI_4 / 4, -M_PI_4 / 4, 0.0]
        shakingLidAnimation.duration = 0.6
        shakingLidAnimation.fillMode = kCAFillModeForwards
        shakingLidAnimation.isAdditive = true
        truckImageView?.layer.add(shakingLidAnimation, forKey: "Starting animation")
        CATransaction.commit()
    }
    
    private func addSecondAnimation() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.animateMovingTruck()
            self.constantlyShakeTruck()
        }
        let shakingAnimation = CAKeyframeAnimation(keyPath: TTAnimations.ZRotation.rawValue)
        shakingAnimation.values = [M_PI_4 / 16, -M_PI_4 / 16, M_PI_4 / 16, -M_PI_4 / 16, M_PI_4 / 16, -M_PI_4 / 16]
        shakingAnimation.fillMode = kCAFillModeForwards
        shakingAnimation.isAdditive = true
        shakingAnimation.duration = 0.2
        truckImageView?.layer.add(shakingAnimation, forKey: "Constant shaking animation")
        CATransaction.commit()
    }
    
    private func constantlyShakeTruck() {
        let constantShakingAnimation = CAKeyframeAnimation(keyPath: TTAnimations.ZRotation.rawValue)
        constantShakingAnimation.values = [M_PI_4 / 16, -M_PI_4 / 16]
        constantShakingAnimation.fillMode = kCAFillModeForwards
        constantShakingAnimation.isAdditive = true
        constantShakingAnimation.repeatCount = .greatestFiniteMagnitude
        constantShakingAnimation.duration = 0.2
        truckImageView?.layer.add(constantShakingAnimation, forKey: "Constant shaking animation")
    }
    
    private func animateMovingTruck() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.delegate?.finishedAnimatingView()
            self.stopAnimating()
        }
        let displacementAnimation = CABasicAnimation(keyPath: TTAnimations.XPosition.rawValue)
        displacementAnimation.fromValue = 0.0
        displacementAnimation.toValue = 300
        displacementAnimation.isAdditive = true
        displacementAnimation.duration = 1.0
        displacementAnimation.fillMode = kCAFillModeForwards
        truckImageView?.layer.add(displacementAnimation, forKey: "Moving truck animation")
        CATransaction.commit()
        self.delegate?.finishedAnimatingView()
    }
    
     //MARK: TTAnimation
    
    func stopAnimating() {
        truckImageView?.layer.removeAllAnimations()
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
        let truckImg = UIImageView(image: UIImage(named: "delivery-truck"))
        truckImg.frame = bounds
        addSubview(truckImg)
        truckImageView = truckImg
    }
}
