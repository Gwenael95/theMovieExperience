//
//  FilmDetailsViewController.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 24/03/2021.
//

import UIKit

class FilmDetailsViewController: UIViewController {

    var authors : [String] = ["Stanlee Kubric", "Steven Spielberg"]
    var actors : [String] = ["Jean Dujardin", "Jack Nicholson", "Jean Reno"]
    var filmName = "La derniere bataille"
    var poster = ""
    var date = "19 mai 1974"
    
    
    @IBOutlet weak var authorsLabel: UILabel!
    
    @IBOutlet weak var actorsLabel: UILabel!
    
    @IBOutlet weak var filmNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateLabel.text = self.date
        self.filmNameLabel.text = self.filmName
        self.authorsLabel.text = self.authors.joined(separator: ", ")
        self.actorsLabel.text = self.actors.joined(separator: ", ")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
