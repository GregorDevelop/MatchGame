//
//  ViewController.swift
//  MatchGame
//
//  Created by Gregor Kramer on 17.02.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var firstFlippedCardIndexPath: IndexPath?

    let model = CardModel()
    
    var cardsArray = [Card]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsArray = model.getCards()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    //MARK:- DataSource Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        let cardForCell = cardsArray[indexPath.row]
        cell.configureCell(cardForCell)
        
        return cell
    }
    
    //MARK:- Delegate Methods

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if selectedCell?.selectedCard?.isFlipped == false {
            selectedCell?.flipUp()
            
            if firstFlippedCardIndexPath == nil {
                firstFlippedCardIndexPath = indexPath
            } else {
                checkForMatch(indexPath)
            }
        }
    }
    
    func checkForMatch(_ secondFlippedCardIndexPath: IndexPath) {
        
        let cardOne = cardsArray[firstFlippedCardIndexPath!.row]
        let cardTwo = cardsArray[secondFlippedCardIndexPath.row]
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndexPath!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndexPath) as? CardCollectionViewCell
        
        if cardOne.imageName == cardTwo.imageName {
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        } else {
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            
        }
        
        firstFlippedCardIndexPath = nil
        
    }
    
}




