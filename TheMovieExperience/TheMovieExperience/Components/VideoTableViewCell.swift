//
//  VideoTableViewCell.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell{

    
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var videoTypeLabel: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
