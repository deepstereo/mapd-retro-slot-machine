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
    
    @IBOutlet weak var spinner: UIPickerView!
    
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
        return 97
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = [
            UIImage(named: "shroom")!,
            UIImage(named: "invader")!,
            UIImage(named: "star")!,
            UIImage(named: "wizard")!,
            UIImage(named: "joystick")!,
            UIImage(named: "cherry")!,
            UIImage(named: "heart")!
        ]
        
        spinner.showsSelectionIndicator = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

