//
//  Library.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 1/15/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation


class Library {
    
    //MARK: Variables
    
    static var animations = [Animation]()
    
    //MARK: Functions
    
    static func GetModel() -> [Animation] {
        initializeModel()
        return animations
    }
    
    private static func initializeModel() {
        let backButtonAnimation = Animation()
        backButtonAnimation.style = .Backwards
        backButtonAnimation.name = "Back button"
        backButtonAnimation.imageName = "arrow"
        backButtonAnimation.animationDescription = "Animates the arrow out of the frame. The arrow will move left and then fade away."
        let refreshButton = Animation()
        refreshButton.style = .Cycling
        refreshButton.name = "Refresh cycling button"
        refreshButton.imageName = "cycle"
        refreshButton.animationDescription = "The arrows will animate in a circular motion for four cycles. This animation is not infinite and can be stopped at anytime."
        let flippingCoinButton = Animation()
        flippingCoinButton.style = .Flipping
        flippingCoinButton.name = "Flipping coin"
        flippingCoinButton.imageName = "coin"
        flippingCoinButton.animationDescription = "The coin will jump in the air and flip. The image will be the same in both sides. Once the coin comes back to its original position, it will stop spinning."
        let colorSwappingButton = Animation()
        colorSwappingButton.style = .ColorSwapping
        colorSwappingButton.name = "Color changing button"
        colorSwappingButton.imageName = "colorButton"
        colorSwappingButton.animationDescription = "The view will change color several times before returning to its original color. If tapped, the animation will stop and the view will revert to black."
        let colorShiftingSquares = Animation()
        colorShiftingSquares.style = .AnimatingColorSwapping
        colorShiftingSquares.name = "Color shifting squares"
        colorShiftingSquares.imageName = "RotatingColorSquares"
        colorShiftingSquares.animationDescription = "This view will animate infinitely. The squares will spin around as they move away from the center and then back. The squares will be constantly changing color. The animation can only be stopped by tapping the view."
        let trashcanButton = Animation()
        trashcanButton.style = .Shaking
        trashcanButton.name = "Shaking trashcan"
        trashcanButton.imageName = "waste-bin"
        trashcanButton.animationDescription = "The lid of the trash can will go up and shake. It will then go back down and bounce with the can."
        let rentACarButton = Animation()
        rentACarButton.style = .ShakingDisplacement
        rentACarButton.name = "Moving car button"
        rentACarButton.imageName = "delivery-truck"
        rentACarButton.animationDescription = "The truck will shake simulating the engine starting. It will slightly shake as if moving along the road. The truck will move out of the frame."
        
        animations.append(backButtonAnimation)
        animations.append(refreshButton)
        animations.append(flippingCoinButton)
        animations.append(colorSwappingButton)
        animations.append(colorShiftingSquares)
        animations.append(trashcanButton)
        animations.append(rentACarButton)
    }
    
}
