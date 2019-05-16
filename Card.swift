//
//  Card.swift
//  Concentration
//
//  Created by Edwina Edward on 1/1/19.
//  Copyright © 2019 Edwinae. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    //since Model is UI independent, it doesn't interact with the emojis.
    static var identifierFactory = 0
    //since it's static, the card # will always be unique
    //don't nneed Card. b/c it's a static func
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init()
        //allows us to call Card and only declare identifier
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
