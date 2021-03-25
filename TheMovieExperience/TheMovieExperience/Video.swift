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
    var imageLink : String
    var type: String
    var videoLink : String
    
    init?(name: String, imageLink: String, type: String, videoLink : String) {
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || type.isEmpty || imageLink.isEmpty || videoLink.isEmpty{
            return nil
        }
        
        self.name = name
        self.imageLink = imageLink
        self.type = type
        self.videoLink = videoLink
    }
}
