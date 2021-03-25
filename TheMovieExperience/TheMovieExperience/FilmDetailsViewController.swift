//
//  FilmDetailsViewController.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 24/03/2021.
//

import UIKit
import WebKit

extension UIImageView {
    
    /**
     get data from an url
    */
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
    
    /**
     download image from an url to display image to the current UIImageView
     */
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

class FilmDetailsViewController: UIViewController /* , UITableViewDataSource, UITableViewDelegate */{

    var authors : [String] = ["Stanlee Kubric", "Steven Spielberg"]
    var actors : [String] = ["Jean Dujardin", "Jack Nicholson", "Jean Reno"]
    var filmName = "La derniere bataille"
    var poster = "https://image.blockbusterbd.net/00416_main_image_04072019225805.png" // an url
    var date = "19 mai 1974"
    let apiImgUrl = "https://image.tmdb.org/t/p/w500/" // + path
    // get image by language https://api.themoviedb.org/3/movie/551/images?api_key=b08dd80fbf5aa44ca65a80f96b6452e2&language=en
    
    let videoYoutubeUrl = "https://www.youtube.com/watch?v=" + "ftTX4FoBWlE" // + key
    // get video keys for youtube : https://api.themoviedb.org/3/movie/551/videos?api_key=b08dd80fbf5aa44ca65a80f96b6452e2&language=en-US
    
    let previewImgYoutubeUrl = "https://i.ytimg.com/vi/" + "ftTX4FoBWlE" + "/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&amp;rs=AOn4CLCw1BAmwgAuP1vSuZ4ucr35TYfmOA"
    
    var videos = [Video]()

    
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var tableView: VideoTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.setupTable(view: self)
        
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        self.tableView.loadSampleVideos()
        self.loadPage()

        /*
        print(self.videoYoutubeUrl)
        let url = URL(string: self.videoYoutubeUrl)!
        let request =  URLRequest (url: url)
        self.webView.load(request)*/
               
        // Do any additional setup after loading the view.
    }
    
    func loadPage(){
        setUIContent(date: self.date, filmName: self.filmName, authors: self.authors.joined(separator: ", "), actors: self.actors.joined(separator: ", "), urlString:self.poster)
    }
    
    func setUIContent(date : String, filmName: String, authors:String, actors:String, urlString:String){
        self.dateLabel.text = "Date : " + date
        self.filmNameLabel.text = filmName
        self.authorsLabel.text = authors
        self.actorsLabel.text = actors
        
        let url = URL(string: urlString)
        self.backgroundImage.downloadImage(from: url!)
        //self.setImageByDownload(from: urlString)
    }
    
    
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "videoTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VideoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of videoTableViewCell.")
        }
        
        // Fetches the appropriate video for the data source layout.
        let video = self.videos[indexPath.row]
        //let imgUrl = URL(string: video.imageLink)
        
        cell.videoNameLabel.text = video.name
        //cell.videoImageView.downloadImage(from: imgUrl!)
        cell.videoTypeLabel.text = video.type
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.purple
        }
        else{
            cell.backgroundColor = UIColor.yellow
        }

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let  vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController( identifier:"webView") as? WebViewController
        {
            vc.link = self.videos[indexPath.row].videoLink
            self.present(vc, animated:true , completion:nil)
            
        }
 
    }
 */
    
    
    
    /**
     @deprecated
        used to download and set an image in a UIImageView
     */
    /*
    func setImageByDownload(from url: String, imageView : UIImageView) {
        guard let imageURL = URL(string: url) else { return }

        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    */
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
