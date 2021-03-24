//
//  FilmDetailsViewController.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 24/03/2021.
//

import UIKit

extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}

class FilmDetailsViewController: UIViewController {

    var authors : [String] = ["Stanlee Kubric", "Steven Spielberg"]
    var actors : [String] = ["Jean Dujardin", "Jack Nicholson", "Jean Reno"]
    var filmName = "La derniere bataille"
    var poster = "https://image.blockbusterbd.net/00416_main_image_04072019225805.png" // an url
    var date = "19 mai 1974"
    
    
    @IBOutlet weak var authorsLabel: UILabel!
    
    @IBOutlet weak var actorsLabel: UILabel!
    
    @IBOutlet weak var filmNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadPage()
       
        // Do any additional setup after loading the view.
    }
    
    func loadPage(){
        setUIContent(date: self.date, filmName: self.filmName, authors: self.authors.joined(separator: ", "), actors: self.actors.joined(separator: ", "), urlString:self.poster)
    }
    
    func setUIContent(date : String, filmName: String, authors:String, actors:String, urlString:String){
        self.dateLabel.text = date
        self.filmNameLabel.text = filmName
        self.authorsLabel.text = authors
        self.actorsLabel.text = actors
        
        let url = URL(string: urlString)
        self.posterImageView.downloadImage(from: url!)
        //self.setImage(from: url)
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
       URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
       getData(from: url) {
          data, response, error in
          guard let data = data, error == nil else {
             return
          }
          DispatchQueue.main.async() {
            self.posterImageView.image = UIImage(data: data)
         }
       }
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
