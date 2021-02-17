//
//  ViewController.swift
//  MatchGame
//
//  Created by Gregor Kramer on 17.02.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var milliseconds = 10 * 1000
    
    var timer: Timer?
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var firstFlippedCardIndexPath: IndexPath?

    let model = CardModel()
    
    var cardsArray = [Card]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsArray = model.getCards()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFire), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
    }

    //MARK:- Timer Methods

    @objc func timerFire() {
        milliseconds -= 1
        let seconds: Double = Double(milliseconds) / 1000.0
        timerLabel.text = String(format: "Time Remaining: %.2f", seconds)
        
        if milliseconds == 0 {
            timer?.invalidate()
            timerLabel.textColor = .systemRed
            
            checkForGameEnd()
        }
        
        
    }
    
    //MARK:- DataSource Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        

        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        let cardCell = cell as? CardCollectionViewCell
        let cardForCell = cardsArray[indexPath.row]
        cardCell?.configureCell(cardForCell)
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
    
    //MARK:- CheckForMatch Method

    
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
            
            checkForGameEnd()
            
        } else {
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            
        }
        
        firstFlippedCardIndexPath = nil
        
    }
    //MARK:- checkForGameEnd Method

    
    func checkForGameEnd() {
        var hasWon = true
        
        for card in cardsArray {
            if card.isMatched == false {
                hasWon = false
                break
            }
        }
        
        if hasWon {
            showAlert(title: "Congratulations!", message: "You've won the game! ")
        } else {
            if milliseconds <= 0 {
                showAlert(title: "Time's Up", message: "Sorry, better luck next time!")
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}




