//
//  Preferences.swift
//  TheMovieExperience
//
//  Created by guillaume on 25/03/2021.
//

import Foundation

class Properties {
    struct APIProperties : Codable {
        let API_KEY : String
        let API_URL : String
    }

    /*func getPlist(withName name: String) -> [String]?
    {
        if  let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path)
        {
            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String]
        }

        return nil
    }*/
    
    static func parseConfig() -> APIProperties {
        let url = Bundle.main.url(forResource: "Properties", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(APIProperties.self, from: data)
    }


    /*static func load() -> APIPreferences {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let plistURL = documents.appendingPathComponent("Properties.plist")
        
        let decoder = PropertyListDecoder()
        
        var nsDictionary: NSDictionary?
         if let path = Bundle.main.path(forResource: "Preferences", ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
         }

        guard let data = try? Data.init(contentsOf: plistURL),
          let preferences = try? decoder.decode(APIPreferences.self, from: data)
        else { return APIPreferences(API_KEY: "key test", API_URL: "url test") }
        return preferences
      }*/

}
