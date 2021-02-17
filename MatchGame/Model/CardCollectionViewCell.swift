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
        
        if cardForCell.isMatched == true {
            frontImageView.alpha = 0
            backImageView.alpha = 0
        } else {
            frontImageView.alpha = 1
            backImageView.alpha = 1
        }
        
        if cardForCell.isFlipped == true {
            flipUp(speed: 0)
        } else {
            flipDown(speed: 0, delay: 0)
        }
        
    }
    
    
    
    func flipUp(speed: TimeInterval = 0.5) {
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        selectedCard?.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.5, delay: TimeInterval = 0.5 ) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        }
        selectedCard?.isFlipped = false
    }
    
    func remove() {
        
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
    }
    
}
