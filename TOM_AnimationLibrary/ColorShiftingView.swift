//
//  ColorShiftingView.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 3/9/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class ColorShiftingView: UIView, TTAnimation {
    
    //MARK: Variables
    
    var delegate: TTAnimationDelegate?
    
    //MARK: Animation
    
    private func addAnimations() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.delegate?.finishedAnimatingView()
        }
        let shiftingColorsAnimation = CAKeyframeAnimation(keyPath: TTAnimations.BackgroundColor.rawValue)
        shiftingColorsAnimation.values = [UIColor.black.cgColor, UIColor.red.cgColor, UIColor.purple.cgColor,
                                          UIColor.blue.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.black.cgColor]
        shiftingColorsAnimation.duration = 3.0
        shiftingColorsAnimation.fillMode = kCAFillModeForwards
        shiftingColorsAnimation.isAdditive = true
        layer.add(shiftingColorsAnimation, forKey: "Shifting colors")
        CATransaction.commit()
    }
    
    //MARK: TTAnimation
    
    func stopAnimating() {
        layer.removeAllAnimations()
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
        backgroundColor = UIColor.black
        isOpaque = false
        contentMode = .redraw
        layer.cornerRadius = bounds.width * 0.2
    }
}
