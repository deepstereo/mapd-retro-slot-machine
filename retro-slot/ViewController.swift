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
    var bet = 0
    
    @IBOutlet weak var spinner: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if bet == 0 {
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
        winLabel.text = "Choose bet"
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
    
    
    
    // Actions
    
    @IBAction func spin(_ sender: UIButton) {
        
        var score = 1000
        var numInRow = -1
        var lastValue = -1
        
        for i in 0..<3 {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastValue {
                numInRow += 1
            } else {
                numInRow = 1
            }
            
            lastValue = newValue
            spinner.selectRow(newValue, inComponent: i, animated: true)
            spinner.reloadComponent(i)

        }
        
            switch numInRow {
            case 1:
                winLabel.text = "You lost!"
                score = score - bet
                scoreLabel.text = String(score)
            case 2:
                winLabel.text = "You won!"
                score = score + bet
                scoreLabel.text = String(score)
            case 3:
                winLabel.text = "Jackpot!"
                score = score + 60
                scoreLabel.text = String(score)
            default:
                winLabel.text = ""
            }
        
        bet = 0
    }
    
    @IBAction func bet(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            bet = 10
            winLabel.text = "You bet 10"
            spinButton.isEnabled = true
        case 1:
            bet = 20
            winLabel.text = "You bet 20"
            spinButton.isEnabled = true
        case 2:
            bet = 30
            winLabel.text = "You bet 30"
            spinButton.isEnabled = true
        default:
            print(bet)
        }
    }
    
    
    // Pickerview implementation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
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

