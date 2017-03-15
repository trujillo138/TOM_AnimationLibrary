//
//  LibraryViewController.swift
//  TOM_AnimationLibrary
//
//  Created by Tomas Trujillo on 2/5/17.
//  Copyright © 2017 TOMApps. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Variables
    
    private var animations = Library.GetModel()
    
    private struct LibraryVCConstants {
        static let LibraryTableViewCellIdentifier = "Library table view cell"
        static let LibraryDetailAnimationSegueIdentifier = "showAnimationSegueIdentifier"
    }
    
    //MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LibraryTableViewCell", bundle: nil), forCellReuseIdentifier: LibraryVCConstants.LibraryTableViewCellIdentifier)
    }
    
    //MARK: UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryVCConstants.LibraryTableViewCellIdentifier) as? LibraryTableViewCell else {
            return UITableViewCell()
        }
        let animation = animations[indexPath.row]
        cell.animationImageName = animation.imageName
        cell.animationName = animation.name
        cell.animationDescription = animation.animationDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: LibraryVCConstants.LibraryDetailAnimationSegueIdentifier, sender: tableView.cellForRow(at: indexPath))
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == LibraryVCConstants.LibraryDetailAnimationSegueIdentifier {
            guard let destinationController = segue.destination as? AnimationViewController,
                    let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            destinationController.animation = animations[indexPath.row]
        }
    }

}
