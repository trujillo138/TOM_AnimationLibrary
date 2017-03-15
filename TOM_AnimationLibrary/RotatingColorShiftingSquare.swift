//
//  RotatingColorShiftingSquare.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 3/12/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class RotatingColorShiftingSquare: UIView, TTAnimation {
    
    //MARK: Variables
    
    var delegate: TTAnimationDelegate?
    
    private var topRightSquare: CAShapeLayer?
    private var topLeftSquare: CAShapeLayer?
    private var bottomRightSquare: CAShapeLayer?
    private var bottomLeftSquare: CAShapeLayer?
    private let outerRadius: CGFloat = 50.0
    private let innerRadius: CGFloat = 5.0
    
    //MARK: Animation
    
    private func addAnimations() {
        addAnimationsTo(shapeLayer: topRightSquare)
        addAnimationsTo(shapeLayer: topLeftSquare)
        addAnimationsTo(shapeLayer: bottomRightSquare)
        addAnimationsTo(shapeLayer: bottomLeftSquare)
        addRotationToView()
    }
    
    private func addAnimationsTo(shapeLayer: CAShapeLayer?) {
        addMovingAnimationTo(shapeLayer: shapeLayer)
        addShiftingColorAnimation(toLayer: shapeLayer)
    }
    
    private func addShiftingColorAnimation(toLayer shapeLayer: CAShapeLayer?) {
        let colorAnimation = CAKeyframeAnimation(keyPath: TTAnimations.FillColor.rawValue)
        colorAnimation.fillMode = kCAFillModeForwards
        colorAnimation.isAdditive = true
        colorAnimation.duration = 4.0
        colorAnimation.repeatCount = .greatestFiniteMagnitude
        colorAnimation.values = [UIColor.black.cgColor, UIColor.orange.cgColor, UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor]
        shapeLayer?.add(colorAnimation, forKey: "Color animationn")
    }
    
    private func addMovingAnimationTo(shapeLayer: CAShapeLayer?) {
        guard let shape = shapeLayer else {
            return
        }
        let outerPoint = determineOuterMovingPointFor(shapeLayer: shape)
        let movingAnimation = CAKeyframeAnimation(keyPath: TTAnimations.Position.rawValue)
        movingAnimation.isAdditive = true
        movingAnimation.fillMode = kCAFillModeForwards
        movingAnimation.duration = 1.0
        movingAnimation.values = [[0.0, 0.0],[outerPoint.x, outerPoint.y],[0.0, 0.0]]
        movingAnimation.repeatCount = .greatestFiniteMagnitude
        shape.add(movingAnimation, forKey: "Moving animation")
    }
    
    private func determineOuterMovingPointFor(shapeLayer: CAShapeLayer) -> CGPoint {
        guard let shapeBounds = shapeLayer.path?.boundingBox else {
            return CGPoint.zero
        }
        let centerX = bounds.midX
        let centerY = bounds.midY
        let pointX = shapeBounds.origin.x + shapeBounds.width / 2
        let pointY = shapeBounds.origin.y + shapeBounds.height / 2
        let deltaX = pointX - centerX
        let deltaY = centerY - pointY
        let disp = deltaX > 0 ? 0.0 : M_PI
        let angle = atan(deltaY / deltaX) + CGFloat(disp)
        return CGPoint(x: cos(angle) * outerRadius, y: -sin(angle) * outerRadius)
    }
    
    private func addRotationToView() {
        let rotationAnimation = CABasicAnimation(keyPath: TTAnimations.ZRotation.rawValue)
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.isAdditive = true
        rotationAnimation.duration = 2.0
        rotationAnimation.repeatCount = .greatestFiniteMagnitude
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = M_PI_2
        layer.add(rotationAnimation, forKey: "Rotation animation")
    }
    
    //MARK: TTAnimation
    
    func stopAnimating() {
        topRightSquare?.removeAllAnimations()
        topLeftSquare?.removeAllAnimations()
        bottomRightSquare?.removeAllAnimations()
        bottomLeftSquare?.removeAllAnimations()
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
        backgroundColor = UIColor.clear
        isOpaque = false
        contentMode = .redraw
        addSquares()
    }
    
    private func addSquares() {
        let squareSide = bounds.width * 0.45
        let firstSquare = UIBezierPath(roundedRect: CGRect(x: 0.0, y: 0.0, width: squareSide, height: squareSide) , cornerRadius: squareSide * 0.1)
        let secondSquare = UIBezierPath(roundedRect: CGRect(x: bounds.width - squareSide, y: 0.0, width: squareSide, height: squareSide) , cornerRadius: squareSide * 0.1)
        let thirdSquare = UIBezierPath(roundedRect: CGRect(x: 0.0, y: bounds.height - squareSide, width: squareSide, height: squareSide) , cornerRadius: squareSide * 0.1)
        let fourthSquare = UIBezierPath(roundedRect: CGRect(x: bounds.width - squareSide, y: bounds.height - squareSide, width: squareSide, height: squareSide) , cornerRadius: squareSide * 0.1)
        topLeftSquare = setupShapeLayer(withPath: firstSquare)
        topRightSquare = setupShapeLayer(withPath: secondSquare)
        bottomRightSquare = setupShapeLayer(withPath: thirdSquare)
        bottomLeftSquare = setupShapeLayer(withPath: fourthSquare)
    }
    
    private func setupShapeLayer(withPath path: UIBezierPath) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.black.cgColor
        layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
}
