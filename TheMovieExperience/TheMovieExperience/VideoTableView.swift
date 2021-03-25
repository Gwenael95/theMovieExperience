//
//  VideoTableView.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import UIKit

class VideoTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var videos = [Video]()
   
    func loadSampleVideos() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
    
        guard let video1 = Video(name: "last fight", image: photo1, type: "Trailer", link: "") else {
            fatalError("Unable to instantiate meal1")
        }
         
        guard let video2 = Video(name: "spiderman", image: photo2, type: "Trailer", link:"") else {
            fatalError("Unable to instantiate meal1")
        }
         
        guard let video3 = Video(name: "superman", image: photo3, type: "Trailer", link:"") else {
            fatalError("Unable to instantiate meal1")
        }
        self.videos += [video1, video2, video3]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "videoTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VideoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of videoTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let video = self.videos[indexPath.row]
        
        cell.videoNameLabel.text = video.name
        cell.videoImageView.image = video.image
        cell.videoTypeLabel.text = video.type
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.purple
        }
        else{
            cell.backgroundColor = UIColor.yellow
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController( identifier:"webView") as? WebViewController
        {
            vc.link = self.videos[indexPath.row].link
            self.present(vc, animated:true , completion:nil)
            
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
