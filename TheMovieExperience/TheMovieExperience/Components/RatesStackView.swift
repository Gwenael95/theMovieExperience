//
//  RatesStackView.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 26/03/2021.
//

import UIKit

class RatesStackView: UIStackView {
    let star = UIImage(named: "star.svg")
    let starEmpty = UIImage(named: "starEmpty.svg")
    let starHalf = UIImage(named: "starHalf.svg")

    let rateMax = 10
    let starMax = 5
    
    func updateUIRate(rateValue : Float){
        let unit = self.rateMax / self.starMax // ==2
        let nbFilled : Int = Int(floor(rateValue / Float(unit))) // 3
        let remaining = (rateValue / Float(unit)).truncatingRemainder(dividingBy: Float(unit))
        
        var nbHalf = 0
        if (remaining >= (0.25 * Float(unit)) && remaining <= (0.75 * Float(unit))) {
            nbHalf = 1
        }
        let nbEmpty = self.starMax - nbHalf - nbFilled

        addImage(image: star!, nb: nbFilled)
        addImage(image: starHalf!, nb: nbHalf)
        addImage(image: starEmpty!, nb: nbEmpty)

    }
    
    private func addImage(image:UIImage, nb:Int){
        if nb>0 {
            for _ in 1...nb {
                let star = UIImageView(image: image)
                self.addArrangedSubview(star)
            }
        }
        
    }
 
}
