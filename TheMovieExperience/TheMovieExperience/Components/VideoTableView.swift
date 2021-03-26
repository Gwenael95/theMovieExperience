//
//  VideoTableView.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import UIKit

class VideoTableView: UITableView , UITableViewDelegate, UITableViewDataSource  {

    var videos = [MovieVideo]()
    let apiMovie = ApiMovieDb()
    
    func setupTable(view : UIViewController){
        self.delegate = self
        self.dataSource = self
    }
    
    func loadVideos(videos : [MovieVideo]){
        self.videos = videos
    }
    
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "videoTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VideoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of videoTableViewCell.")
        }
        
        // Fetches the appropriate video 
        let video = self.videos[indexPath.row]
        
        let imgUrl = URL(string: apiMovie.getYoutubeImageLink(key: video.key))
        
        cell.videoNameLabel.text = video.name
        cell.videoImageView.downloadImage(from: imgUrl!)
        cell.videoTypeLabel.text = video.type
        
        return cell
    }
    
    
    /**
            used to display a web view with a youtube video, lauch thanks to video url (String)
            When clicking on a cell
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController( identifier:"webView") as? WebViewController
        {
            vc.link = apiMovie.getYoutubeVideoLink(key: self.videos[indexPath.row].key)
            print(vc.link)
            self.window?.rootViewController?.present(vc, animated:true , completion:nil)
        }
    }
    
}
