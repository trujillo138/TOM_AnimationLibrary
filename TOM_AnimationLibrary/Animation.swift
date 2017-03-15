//
//  Animation.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 1/15/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import Foundation

enum AnimationStyle {
    case Backwards
    case Cycling
    case Flipping
    case ColorSwapping
    case AnimatingColorSwapping
    case Shaking
    case ShakingDisplacement
}

class Animation {
    
    var style: AnimationStyle?
    
    var name = ""
    
    var animationDescription = ""
    
    var imageName = ""

}
