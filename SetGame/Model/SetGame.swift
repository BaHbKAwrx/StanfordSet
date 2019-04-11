//
//  SetGame.swift
//  SetGame
//
//  Created by Shmygovskii Ivan on 4/10/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

// our game struct
struct SetGame {
    
    private(set) var score = 0
    
    private var deck = GameDeck()
    private(set) var cardsInGame = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var removedCards = [Card]()
    private(set) var cardsTryMatched = [Card]()
    
    var deckCount: Int { return deck.cards.count}
    
    var isSet: Bool? {
        get {
            guard cardsTryMatched.count == 3 else { return nil }
            return areSet(cards: cardsTryMatched)
        }
        set {
            if newValue != nil {
                if newValue! {
                    score += 20
                }
                else {
                    score -= 10
                }
                cardsTryMatched = selectedCards
                selectedCards.removeAll()
            } else {
                cardsTryMatched.removeAll()
            }
        }
    }
    
    //initing game with 12 cards in game
    init() {
        for _ in 0..<12 {
            if let card = deck.drawCard() {
                cardsInGame += [card]
            }
        }
    }
    
    //func that check if cards are set
    private func areSet(cards: [Card]) -> Bool {
        guard cards.count == 3 else { return false }
        guard (cards[0].color == cards[1].color && cards[1].color == cards[2].color) || (cards[0].color != cards[1].color && cards[1].color != cards[2].color && cards[0].color != cards[2].color ) else { return false }
        guard (cards[0].count == cards[1].count && cards[1].count == cards[2].count) || (cards[0].count != cards[1].count && cards[1].count != cards[2].count && cards[0].count != cards[2].count ) else { return false }
        guard (cards[0].filling == cards[1].filling && cards[1].filling == cards[2].filling) || (cards[0].filling != cards[1].filling && cards[1].filling != cards[2].filling && cards[0].filling != cards[2].filling ) else { return false }
        guard (cards[0].symbol == cards[1].symbol && cards[1].symbol == cards[2].symbol) || (cards[0].symbol != cards[1].symbol && cards[1].symbol != cards[2].symbol && cards[0].symbol != cards[2].symbol ) else { return false }
        return true
    }
    
    mutating func chooseCard(at index: Int) {
        let chosenCard = cardsInGame[index]
        
        if !removedCards.contains(chosenCard) && !cardsTryMatched.contains(chosenCard) {
            if isSet != nil {
                if isSet! {
                    replaceOrRemove3Cards()
                }
                isSet = nil
            }
            if selectedCards.count == 2, !selectedCards.contains(chosenCard) {
                selectedCards += [chosenCard]
                isSet = areSet(cards: selectedCards)
            } else {
                selectedCards.inOut(element: chosenCard)
            }
            score -= 1
        }
        
    }
    
    private mutating func replaceOrRemove3Cards() {
        if let take3Cards = takeCardsFromDeck() {
            cardsInGame.replace(elements: cardsTryMatched, with: take3Cards)
        } else {
            cardsInGame.remove(elements: cardsTryMatched)
        }
        removedCards += cardsTryMatched
        cardsTryMatched.removeAll()
    }
    
    private mutating func takeCardsFromDeck() -> [Card]? {
        var threeCards = [Card]()
        for _ in 0..<3 {
            if let card = deck.drawCard() {
                threeCards += [card]
            } else {
                return nil
            }
        }
        return threeCards
    }
    
    mutating func deal3Cards() {
        if let dealedCards = takeCardsFromDeck() {
            cardsInGame += dealedCards
        }
    }
    
}

extension Array where Element: Equatable {
    
    // switching if element already in Array
    mutating func inOut(element: Element) {
        if let from = self.index(of: element) {
            self.remove(at: from)
        } else {
            self.append(element)
        }
    }
    
    // deleting array from array
    mutating func remove(elements: [Element]) {
        self = self.filter { !elements.contains($0) }
    }
    
    // replacing elements in array
    mutating func replace(elements: [Element], with new: [Element]) {
        guard elements.count == new.count else { return }
        for index in 0..<new.count {
            if let indexMatched = self.index(of: elements[index]) {
                self[indexMatched] = new[index]
            }
        }
    }
    
}
