//
//  Card.swift
//  SetGame
//
//  Created by Shmygovskii Ivan on 4/10/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation


// Our gameCard struct that conforms Equatable protocol
struct Card: Equatable {
    
    // enumeration of avaliable variants of cards characteristics
    //Case Iterable for using .allCases
    enum CharacteristicVariant: Int, CaseIterable {
        case first = 1
        case second
        case third
        
        //var allCases: [CharacteristicVariant] { return [.first, .second, .third] }
    }
    
    // card characterictics
    let color: CharacteristicVariant
    let symbol: CharacteristicVariant
    let count: CharacteristicVariant
    let filling: CharacteristicVariant
    
}
