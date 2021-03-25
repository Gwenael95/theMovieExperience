//
//  Video.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import Foundation
import UIKit

class Video{
    //MARK: Properties
    var name : String
    var image : UIImage?
    var type: String
    var link : String
    
    init?(name: String, image: UIImage?, type: String, link : String) {
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || type.isEmpty  {
            return nil
        }
        self.name = name
        self.image = image
        self.type = type
        self.link = link
    }
}
