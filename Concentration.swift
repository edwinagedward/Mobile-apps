//
//  Concentration.swift
//  Concentration
//
//  Created by Edwina Edward on 1/1/19.
//  Copyright © 2019 Edwinae. All rights reserved.
//

import Foundation
//Totally UI independent

class Concentration
{
    //var cards Array<Card>
    //below is the initialized version
    //var cards = Array<Card>()
    var cards = [Card]() //accepted syntax
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        //ignore card that's already been matched
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //if the cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil //bc now there's 2 cards face up
            } else {
                //if there are no cards up or 2 cards dont match
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func restartGame(numberOfPairsOfCards: Int) {
        for currCard in cards.indices {
            cards[currCard].isFaceUp = false
            cards[currCard].isMatched = false
        }
        var shuffledCards = [Card]()
        var newrandomIndex: Int
        var cardslength = cards.count - 1
        while cardslength >= 0 {
            newrandomIndex = Int(arc4random_uniform(UInt32(cardslength)))
            print("Random index: \(newrandomIndex)")
            print("Cardslength: \(cardslength)")
            shuffledCards.append(cards[newrandomIndex])
            cards.remove(at: newrandomIndex)
            cardslength -= 1
        }
        cards = shuffledCards
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            //since it's a struct, it makes a copy
            cards.append(card)
            cards.append(card)
        }
        //Shuffle Cards
        var shuffledCards = [Card]()
        var newrandomIndex: Int
        var cardslength = cards.count - 1
        while cardslength >= 0 {
            newrandomIndex = Int(arc4random_uniform(UInt32(cardslength)))
            print("Random index: \(newrandomIndex)")
            print("Cardslength: \(cardslength)")
            shuffledCards.append(cards[newrandomIndex])
            cards.remove(at: newrandomIndex)
            cardslength -= 1
        }
        cards = shuffledCards
    }
}
