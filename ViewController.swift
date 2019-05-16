//
//  ViewController.swift
//  Concentration
//
//  Created by Edwina Edward on 12/29/18.
//  Copyright © 2018 Edwinae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    //adding an instance variable w lazy allows it to only run if it's called. Everything will be initialized
    //1st to use card buttons
    // var flipcount: Int, however it's inferred here
    var flipCount = 0 {
        // every time the count changes,
        // didSet will run
        didSet {
          flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    lazy var emojiChoices = chooseTheme()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func newGameButton(_ sender: UIButton) {
        //initialize a new game
        flipCount = 0
        emojiChoices = chooseTheme()
        game.restartGame(numberOfPairsOfCards: (cardButtons.count+1)/2)
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        // IBAction = directive that shows which card
        // type of argument is UIButton
        // _ sender: names of parameter
        flipCount += 1
        //using let bc its a constant
        //CardButtons.firstIndex(of: sender) a problem bc
        //it returns an optional enumerator (set/not set)
        //! = assume its set
        if let cardNumber = cardButtons.firstIndex(of: sender){
           game.chooseCard(at: cardNumber)
            //now, update view from model
            updateViewFromModel()
        }else {
            print("Card not in CardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emoji = Dictionary<Int,String>() //empty dict
    //var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        // if not nil, return. else, return "?"
        return emoji[card.identifier] ?? "?"
    }

    func chooseTheme() -> Array<String> {
        var themeDict = Dictionary<String, Array<String>>()
        themeDict["nature"] = ["🌸", "🌼", "🌞", "🌿", "🦋", "🥀", "🍃", "🍄"]
        themeDict["sports"] = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏒", "🥊", "🏸"]
        themeDict["tech"] = ["📷", "📱", "⌚️", "🕹", "📺", "📟", "🔋", "📡"]
        themeDict["countries"] = ["🇲🇺", "🇳🇱", "🇯🇲", "🇦🇮", "🇨🇦", "🇮🇹", "🇺🇸", "🇭🇹"]
        themeDict["moods"] = ["😁", "😘", "🤓", "🤬", "😑", "🤢", "🤕", "🙄"]
        themeDict["halloween"] = ["🎃","👻","🕸","🦇", "👹", "🕷", "☠️", "🔪"]
        let themes = Array(themeDict.keys)
        var newTheme = Array<String>()
        let length = themes.count - 1
        var randomIndex: Int = 0

        randomIndex = Int(arc4random_uniform(UInt32(length)))
        newTheme = themeDict[themes[randomIndex]]!
        return newTheme
    }
}

