//
//  ViewController.swift
//  SetGame
//
//  Created by Shmygovskii Ivan on 4/10/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var buttonsArray: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dealCardsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in buttonsArray.indices {
            let button = buttonsArray[index]
            button.setTitle(String(index), for: .normal)
            if index < 12 {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    @IBAction func buttonPushed(_ sender: UIButton) {
    }

    @IBAction func dealThreeCards(_ sender: UIButton) {
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
    }
    
}

