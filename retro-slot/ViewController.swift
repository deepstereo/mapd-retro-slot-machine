//
//  ViewController.swift
//  retro-slot
//
//  Created by Sergey Kozak on 31/01/2018.
//  Copyright © 2018 Centennial. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var images = [UIImage()]
    var playerBet = 0
    var playerMoney = 100
    var jackpot = 1000
    var winnings = 0
    var spinResult:[Int] = []
    
    var shrooms = 0
    var invaders = 0
    var stars = 0
    var wizards = 0
    var joysticks = 0
    var cherries = 0
    var hearts = 0

    
    @IBOutlet weak var spinner: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var betButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if playerBet == 0 {
            spinButton.isEnabled = false
        }
        
        images = [
            UIImage(named: "shroom")!,
            UIImage(named: "heart")!,
            UIImage(named: "invader")!,
            UIImage(named: "star")!,
            UIImage(named: "wizard")!,
            UIImage(named: "cherry")!,
            UIImage(named: "joystick")!
        ]
        
        spinner.showsSelectionIndicator = false
        scoreLabel.text = String(playerMoney)
        winLabel.text = "Place bet"
        minusButton.isEnabled = false
        plusButton.isEnabled = false
        spinButton.isEnabled = false
        arc4random_stir()
    }
    
    // Controls
    
    @IBAction func soundSwitch(_ sender: UIButton) {
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        playerBet = 0
        playerMoney = 100
        scoreLabel.text = String(playerMoney)
        winLabel.text = "Place bet"
        validateBet()
    }
    
    @IBAction func quitGame(_ sender: UIButton) {
        exit(0)
    }
    
    
    
    // Game button actions
    
    // utility function to enable or disable bet buttons
    func validateBet() {
        spinButton.isEnabled = playerBet == 0 || playerMoney <= 0 ? false : true
        betButton.isEnabled = playerMoney >= 0 ? true : false
        minusButton.isEnabled = playerBet >= 10 ? true : false
        plusButton.isEnabled = playerMoney > playerBet ? true : false
    }
    
    // bet buttons
    @IBAction func bet(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            playerBet = 10
            winLabel.text = "Your bet: \(playerBet)"
            validateBet()
        case 1:
            playerBet = playerBet - 10
            winLabel.text = "Your bet: \(playerBet)"
            validateBet()
        case 2:
            playerBet = playerBet + 10
            winLabel.text = "Your bet: \(playerBet)"
            validateBet()
        default:
            print(playerBet)
        }
    }
    
    @IBAction func spin(_ sender: UIButton) {

            spinResult = Reels();
            
            for i in 0..<5 {
                spinner.selectRow(spinResult[i], inComponent: i, animated: true)
                spinner.reloadComponent(i)
            }
        
            determineWinnings();
   
    }
    
    // MARK: UTILITY FUNCTIONS
    
    /* Utility function to reset all fruit tallies */
    func resetFruitTally() {
         shrooms = 0
         invaders = 0
         stars = 0
         wizards = 0
         joysticks = 0
         cherries = 0
         hearts = 0
        if playerBet == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:  {
                self.winLabel.text = "Place bet"
            })
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:  {
                self.winLabel.text = "Your bet: \(self.playerBet)"
            })
        }
        validateBet()
    }
    
    
    
    
    /* Utility function to check if a value falls within a range of bounds */
    func checkRange(_ value:Int,_ lowerBounds:Int,_ upperBounds:Int) ->Int {
        if (value >= lowerBounds && value <= upperBounds)
        {
            return value;
        }
        else {
            return -1;
        }
    }
    
    /* When this function is called it determines the betLine results.
     e.g. Bar - Orange - Banana */
    
    func Reels() -> [Int] {
        var betLine = [0, 0, 0, 0, 0];
        var outCome = [0, 0, 0, 0, 0];
        
        for spin in 0..<5 {
            outCome[spin] = Int((drand48() * 100) + 1);
            switch (outCome[spin]) {
            case checkRange(outCome[spin], 20, 40): //20
                betLine[spin] = 1;
                shrooms+=1;
                break;
            case checkRange(outCome[spin], 40, 60)://20
                betLine[spin] = 2;
                invaders+=1;
                break;
            case checkRange(outCome[spin], 60, 75)://15
                betLine[spin] = 3;
                stars+=1;
                break;
            case checkRange(outCome[spin], 75, 85)://10
                betLine[spin] = 4;
                wizards+=1;
                break;
            case checkRange(outCome[spin], 85, 95)://10
                betLine[spin] = 5;
                cherries+=1;
                break;
            case checkRange(outCome[spin], 95, 100)://5
                betLine[spin] = 6;
                joysticks+=1;
                break;
            default://20
                betLine[spin] = 0;
                hearts+=1;
                break;
            }
        }
        return betLine;
    }
    
    /* This function calculates the player's winnings, if any */
    func determineWinnings()
    {
        var win = false;
        if (shrooms >= 3) {
            winnings = playerBet * (shrooms-2);
            win=true;
        }
        else if(hearts >= 3) {
            winnings = playerBet * (hearts-1);
            win=true;
        }
        else if (invaders >= 3) {
            winnings = playerBet * (invaders);
            win=true;
        }
        else if (stars >= 3) {
            winnings = playerBet * (stars + 1);
            win=true;
        }
        else if (wizards >= 3) {
            winnings = playerBet * (wizards + 2);
            win=true;
        }
        else if (hearts >= 3) {
            winnings = playerBet * (hearts + 3);
            win=true;
        }
        else if (joysticks >= 3) {
            winnings = playerBet * (joysticks + 4);
            win=true;
        }
        
        if win {
            winLabel.text = "You won \(winnings)!"
            playerMoney = playerMoney + winnings
            scoreLabel.text = String(playerMoney)
            resetFruitTally()
        } else {
            winLabel.text = "You lost!"
            playerMoney = playerMoney - winnings
            scoreLabel.text = String(playerMoney)
            playerBet = 0
            resetFruitTally()
        }
    }
    
    
    
    
    
    
    
    // Pickerview implementation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 130
    }

   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

