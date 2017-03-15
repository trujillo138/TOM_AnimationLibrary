//
//  AnimationViewController.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 2/23/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController, TTAnimationDelegate {

    //MARK: Outlets
    
    @IBOutlet private weak var animationDescriptionTextView: UITextView!
    
    @IBOutlet private weak var animationViewContainer: UIView!
    
    @IBOutlet private var tapGesture: UITapGestureRecognizer!
    
    //MARK: Variables
    
    var animation: Animation?
    
    private var animating = false
    
    private var animationView: TTAnimation?
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationViewContainer.backgroundColor = UIColor.clear
        animationViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(triggerAnimation(_:))))
        loadAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        insertAnimationInContainer()
    }
    
    //MARK: Gestures
    
    func triggerAnimation(_: UITapGestureRecognizer) {
        if !animating {
            animationView?.beingAnimating()
            animating = true
        } else {
            animationView?.stopAnimating()
            animating = false
        }
    }
    
    //MARK: TTAnimation Delegate
    
    func finishedAnimatingView() {
        animating = false
    }
    
    //MARK: Animation
    
    private func loadAnimation() {
        title = animation?.name
        animationDescriptionTextView.text = animation?.animationDescription ?? ""
    }
    
    private func insertAnimationInContainer() {
        guard let animationStyle = animation?.style else {
            return
        }
        switch animationStyle {
        case .Cycling:
            loadCyclingAnimation()
        case .Backwards:
            loadBackwardsAnimation()
        case .Flipping:
            loadFlippingAnimation()
        case .ColorSwapping:
            loadColorSwappingAnimation()
        case .AnimatingColorSwapping:
            loadAnimationColorSwappingAnimation()
        case .Shaking:
            loadShakingAnimation()
        case .ShakingDisplacement:
            loadShakingDisplacementAnimation()
        }
        animationView?.delegate = self
    }
    
    private func loadCyclingAnimation() {
        let cyclingAnimation = CyclingAnimatingView(frame: animationViewContainer.bounds)
        boundContainerAnd(animation: cyclingAnimation)
        animationView = cyclingAnimation
    }
    
    private func loadBackwardsAnimation() {
        let backAnimation = BackwardsAnimatingView(frame: animationViewContainer.bounds)
        boundContainerAnd(animation: backAnimation)
        animationView = backAnimation
    }
    
    private func loadFlippingAnimation() {
        let flipAnimation = FlippingAnimationView(frame: animationViewContainer.bounds)
        boundContainerAnd(animation: flipAnimation)
        animationView = flipAnimation
    }
    
    private func loadColorSwappingAnimation() {
        let shiftingAnimation = ColorShiftingView(frame: animationViewContainer.bounds)
        boundContainerAnd(animation: shiftingAnimation)
        animationView = shiftingAnimation
    }
    
    private func loadAnimationColorSwappingAnimation() {
        let rotatingColorAnimation = RotatingColorShiftingSquare(frame: animationViewContainer.bounds)
        boundContainerAnd(animation: rotatingColorAnimation)
        animationView = rotatingColorAnimation
    }
    
    private func loadShakingAnimation() {
        let traschCanAnimation = TrashcanAnimationView(frame: animationViewContainer.bounds)
        boundContainerAnd(animation: traschCanAnimation)
        animationView = traschCanAnimation
    }
    
    private func loadShakingDisplacementAnimation() {
        let truckAnimation = StartingTruckAnimationView(frame: animationViewContainer.bounds)
        boundContainerAnd(animation: truckAnimation)
        animationView = truckAnimation
    }

    private func boundContainerAnd(animation: UIView) {
        animationViewContainer.addSubview(animation)
        let leadingConstraint = NSLayoutConstraint(item: animation, attribute: .leading, relatedBy: .equal, toItem: animationViewContainer,
                                               attribute: .leading, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: animation, attribute: .top, relatedBy: .equal, toItem: animationViewContainer,
                                               attribute: .top, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: animation, attribute: .trailing, relatedBy: .equal, toItem: animationViewContainer,
                                               attribute: .trailing, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: animation, attribute: .bottom, relatedBy: .equal, toItem: animationViewContainer,
                                               attribute: .bottom, multiplier: 1.0, constant: 0)
        animation.translatesAutoresizingMaskIntoConstraints = false
        animationViewContainer.addConstraint(leadingConstraint)
        animationViewContainer.addConstraint(topConstraint)
        animationViewContainer.addConstraint(trailingConstraint)
        animationViewContainer.addConstraint(bottomConstraint)
    }
    
}
