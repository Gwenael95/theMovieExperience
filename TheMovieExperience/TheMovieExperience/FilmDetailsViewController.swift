//
//  FilmDetailsViewController.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 24/03/2021.
//

import UIKit
import WebKit

class FilmDetailsViewController: UIViewController {
    var filmName = "La derniere bataille"
    var id = 1
    var date = "19 mai 1974"
    var apiImgUrl = "https://image.tmdb.org/t/p/w500/" // + path
    var genres = [String]()
    var voteAverage : Float = 0
    var overView = ""
    
    let apiMovie = ApiMovieDb()

    
    
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var tableView: VideoTableView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var rateView: RatesStackView!
    @IBOutlet weak var genresLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.setupTable(view: self)
        
        // get movie details and update UI
        let _: () = apiMovie.searchMovieDetails(id:self.id) { result in
           
            DispatchQueue.main.async {
                self.filmName = result!.original_title
                self.date = result!.release_date
                self.apiImgUrl = self.apiMovie.getImageFromMovieDbApi(path: result!.poster_path)
                self.overView = result!.overview
                self.voteAverage = result!.vote_average
                self.genres = result!.genres
                self.loadPage()
            }

        }
        
        // get movie trailers video link and update tableView
        let _: () = apiMovie.searchMovieVideos(id:self.id) { result in
           
            DispatchQueue.main.async {
                self.tableView.loadVideos(videos: result)
                self.tableView.reloadData()
            }

        }
    }
    
    func loadPage(){
        setUIContent(date: self.date, filmName: self.filmName,  overview: self.overView, genres: self.genres.joined(separator: ", "), urlString:self.apiImgUrl, note: self.voteAverage)
    }
    
    func setUIContent(date : String, filmName: String, overview:String, genres: String, urlString:String, note:Float){
        self.dateLabel.text = "Date : " + date
        self.filmNameLabel.text = filmName
        self.overviewLabel.text = overView
        self.genresLabel.text = genres
        self.noteLabel.text = "\(note)"
        self.rateView.updateUIRate(rateValue: note)
        let url = URL(string: urlString)
        self.backgroundImage.downloadImage(from: url!)
        //self.setImageByDownload(from: urlString)
    }
    
    
}
