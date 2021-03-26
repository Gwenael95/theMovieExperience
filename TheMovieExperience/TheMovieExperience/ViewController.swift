//
//  ViewController.swift
//  TheMovieExperience
//
//  Created by Hugo Monnerie on 24/03/2021.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


    
    /**
        used to go to search view with navigation controller
     */
    @IBAction func goToSearchView(_ sender: Any) {
        if let  vc = UIStoryboard (name: "Main", bundle: nil).instantiateViewController( identifier:"searchView") as? SearchViewController{

            self.show(vc, sender: UINavigationController(rootViewController: vc))
        }
    }
}

/**
 used to add properties on element, here border radius
 */
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
