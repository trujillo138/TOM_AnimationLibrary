//
//  TTAnimation.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 2/28/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation

protocol TTAnimation {
    
    var delegate: TTAnimationDelegate? {get set}
    
    func beingAnimating()
    func stopAnimating()
}

protocol TTAnimationDelegate {
    func finishedAnimatingView()
}
