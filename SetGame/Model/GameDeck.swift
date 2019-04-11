//
//  GameDeck.swift
//  SetGame
//
//  Created by Shmygovskii Ivan on 4/10/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

// Our GameDeck struct with all 81 cards in it
struct GameDeck {
    
    private(set) var cards = [Card]()
    
    // initing whole deck and shuffling it
    init() {
        for count in Card.CharacteristicVariant.allCases {
            for color in Card.CharacteristicVariant.allCases {
                for symbol in Card.CharacteristicVariant.allCases {
                    for filling in Card.CharacteristicVariant.allCases {
                        cards.append(Card(color: color, symbol: symbol, count: count, filling: filling))
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    // function for drawing card from deck (when deck isnt empty)
    mutating func drawCard() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: 0)
        } else {
            return nil
        }
    }
    
}
