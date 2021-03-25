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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToTrendingView(_ sender: Any) {
    }
    
    @IBAction func goToSettingView(_ sender: Any) {
        if let  vc = UIStoryboard (name: "Main", bundle: nil).instantiateViewController( identifier:"settingView") as? SettingViewController{

            self.show(vc, sender: UINavigationController(rootViewController: vc))
        }
    }
    
    @IBAction func goToResearchView(_ sender: Any) {
        if let  vc = UIStoryboard (name: "Main", bundle: nil).instantiateViewController( identifier:"mainTableView") as? MainTableViewController{

            self.show(vc, sender: UINavigationController(rootViewController: vc))
        }
    }
}

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
