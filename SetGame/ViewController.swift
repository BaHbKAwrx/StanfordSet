//
//  ViewController.swift
//  SetGame
//
//  Created by Shmygovskii Ivan on 4/10/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game = SetGame()
    
    var colors = [#colorLiteral(red: 1, green: 0.4163245823, blue: 0, alpha: 1), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)]
    var strokeWidths:[CGFloat] = [ -10, 10, -10]
    var alphas:[CGFloat] = [1.0, 0.60, 0.15]

    @IBOutlet var buttonsArray: [SetCardButton]! {
        didSet {
            for button in buttonsArray {
                button.strokeWidths = strokeWidths
                button.colors = colors
                button.alphas = alphas
            }
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dealCardsButton: BorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        updateButtonsFromModel()
        scoreLabel.text = "Your score: \(game.score)"
        dealCardsButton.disable = (game.cardsInGame.count) >= buttonsArray.count
            || game.deckCount == 0
    }
    
    private func updateButtonsFromModel() {
        
        for index in buttonsArray.indices {
            let button = buttonsArray[index]
            if index < game.cardsInGame.count {
                //--------------------------------
                let card = game.cardsInGame[index]
                button.setCard = card
                //-----------Selected----------------------
                button.setBorderColor(color:
                    game.selectedCards.contains(card) ? Colors.selected : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
                //-----------TryMatched----------------------
                if let itIsSet = game.isSet {
                    if game.cardsTryMatched.contains(card) {
                        button.setBorderColor(color:
                            itIsSet ? Colors.matched: Colors.misMatched)
                    }
                }
                //--------------------------------
            } else {
                button.setCard = nil
            }
        }
        
    }
    
    @IBAction func buttonPushed(_ sender: SetCardButton) {
        if let cardNumber = buttonsArray.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }

    @IBAction func dealThreeCards(_ sender: UIButton) {
        if (game.cardsInGame.count + 3) <= buttonsArray.count {
            game.deal3Cards()
            updateViewFromModel()
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = SetGame()
        buttonsArray.forEach { $0.setCard = nil }
        updateViewFromModel()
    }
    
}

extension ViewController {
    //------------------ Constants -------------
    private struct Colors {
        static let hint = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
        static let selected = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        static let matched = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        static var misMatched = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
}

