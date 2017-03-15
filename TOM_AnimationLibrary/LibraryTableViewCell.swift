//
//  LibraryTableViewCell.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 2/5/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

    //MARK: Variables
    
    var animationImageName = "" {
        didSet {
            animationPicture.image = UIImage(named: animationImageName)
        }
    }
    
    var animationName = "" {
        didSet {
            animationNameLabel.text = animationName
        }
    }
    
    var animationDescription = "" {
        didSet {
            animationDescriptionLabel.text = animationDescription
        }
    }
    
    //MARK: Outlets
    
    @IBOutlet private weak var animationPicture: UIImageView!
    
    @IBOutlet private weak var animationNameLabel: UILabel!
    
    @IBOutlet private weak var animationDescriptionLabel: UILabel!
    
}
