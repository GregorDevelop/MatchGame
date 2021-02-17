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
    
    func configureCell(_ cardForCell: Card) {
        
        frontImageView.image = UIImage(named: cardForCell.imageName)
        backImageView.image = UIImage(named: cardForCell.imageName)
        
    }
    
    
}
