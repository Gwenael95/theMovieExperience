//
//  VideoTableView.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import UIKit

class VideoTableView: UITableView /*, UITableViewDelegate, UITableViewDataSource */ {

    var videos = [Video]()
    
    func setupTable(view : UIViewController){
        //self.delegate = self
        //self.dataSource = self
    }
    
    
    func loadSampleVideos() {
    
        let videoYoutubeUrl = "https://www.youtube.com/watch?v=" + "ftTX4FoBWlE" // + key
    
        let previewImgYoutubeUrl = "https://i.ytimg.com/vi/" + "ftTX4FoBWlE" + "/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&amp;rs=AOn4CLCw1BAmwgAuP1vSuZ4ucr35TYfmOA"
        
        
        guard let video1 = Video(name: "last fight", imageLink: previewImgYoutubeUrl, type: "Trailer", videoLink: videoYoutubeUrl) else {
            fatalError("Unable to instantiate meal1")
        }
         
        guard let video2 = Video(name: "spiderman", imageLink: previewImgYoutubeUrl, type: "Trailer", videoLink:videoYoutubeUrl) else {
            fatalError("Unable to instantiate meal1")
        }
         
        guard let video3 = Video(name: "superman", imageLink: previewImgYoutubeUrl, type: "Trailer", videoLink:videoYoutubeUrl) else {
            fatalError("Unable to instantiate meal1")
        }
        self.videos += [video1, video2, video3]
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
        let imgUrl = URL(string: video.imageLink)
        
        cell.videoNameLabel.text = video.name
        cell.videoImageView.downloadImage(from: imgUrl!)
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
            self.window?.rootViewController?.present(vc, animated:true , completion:nil)
        }
    }
    
    */
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
