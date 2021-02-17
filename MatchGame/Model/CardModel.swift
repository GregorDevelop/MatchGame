//
//  CardModel.swift
//  MatchGame
//
//  Created by Gregor Kramer on 17.02.2021.
//

import Foundation


class CardModel {
    
    
    func getCards() -> [Card] {
        
        var generatedNumbers = [Int]()
        
        var generatedCards = [Card]()
        
        while generatedNumbers.count < 8 {
            let cardOne = Card()
            let cardTwo = Card()
            
            let randomNumber = Int.random(in: 1...13)
            
            if generatedNumbers.contains(randomNumber) == false {
                
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCards += [cardOne, cardTwo]
                
                generatedNumbers.append(randomNumber)
            }
        }        
        generatedCards.shuffle()
        
        return generatedCards
    }
}
