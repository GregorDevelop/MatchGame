//
//  CardCollectionViewCell.swift
//  MatchGame
//
//  Created by Gregor Kramer on 17.02.2021.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var selectedCard: Card?
    
    func configureCell(_ cardForCell: Card) {
        
        frontImageView.image = UIImage(named: cardForCell.imageName)
        
        selectedCard = cardForCell
        
        if cardForCell.isFlipped == true {
            flipUp(speed: 0)
        } else {
            flipDown(speed: 0)
        }
        
    }
    
    
    
    func flipUp(speed: TimeInterval = 0.5) {
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        selectedCard?.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.5) {
        UIView.transition(from: frontImageView, to: backImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        selectedCard?.isFlipped = false
    }
    
}
