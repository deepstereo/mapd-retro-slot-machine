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
    var playerMoney = 50
    
    
    @IBOutlet weak var spinner: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if playerBet == 0 {
            spinButton.isEnabled = false
        }
        
        images = [
            UIImage(named: "shroom")!,
            UIImage(named: "invader")!,
            UIImage(named: "star")!,
            UIImage(named: "wizard")!,
            UIImage(named: "joystick")!,
            UIImage(named: "cherry")!,
            UIImage(named: "heart")!
        ]
        
        spinner.showsSelectionIndicator = false
        scoreLabel.text = String(playerMoney)
        winLabel.text = "Choose bet"
        minusButton.isEnabled = false
        plusButton.isEnabled = false
        spinButton.isEnabled = false
        arc4random_stir()
    }
    
    // Controls
    
    @IBAction func soundSwitch(_ sender: UIButton) {
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
    }
    
    @IBAction func quitGame(_ sender: UIButton) {
        exit(0)
    }
    
    
    
    // Game button actions
    
    // utility function to enable or disable bet buttons
    func validateBet() {
        spinButton.isEnabled = playerBet == 0 ? false : true
        minusButton.isEnabled = playerBet >= 10 ? true : false
        plusButton.isEnabled = playerMoney > playerBet ? true : false
    }
    
    // bet buttons
    @IBAction func bet(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            playerBet = 10
            winLabel.text = "You bet \(playerBet)"
            validateBet()
        case 1:
            playerBet = playerBet - 10
            winLabel.text = "You bet \(playerBet)"
            validateBet()
        case 2:
            playerBet = playerBet + 10
            winLabel.text = "You bet \(playerBet)"
            validateBet()
        default:
            print(playerBet)
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

