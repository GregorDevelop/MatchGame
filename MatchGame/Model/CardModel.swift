//
//  CardModel.swift
//  MatchGame
//
//  Created by Gregor Kramer on 17.02.2021.
//

import Foundation


class CardModel {
    
    
    func getCards() -> [Card] {
        
        var generatedCards = [Card]()
        
        for _ in 1...8 {
            let cardOne = Card()
            let cardTwo = Card()
            
            let randomNumber = Int.random(in: 1...13)
            
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            generatedCards += [cardOne, cardTwo]
        }        
        generatedCards.shuffle()
        
        return generatedCards
    }
}
