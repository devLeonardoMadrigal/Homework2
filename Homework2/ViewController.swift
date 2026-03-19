//
//  ViewController.swift
//  Homework2
//
//  Created by Leonardo Madrigal on 3/18/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var learningLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIValues()
    }
    



    @IBAction func signInButtonClicked(_ sender: Any) {
        print("Button Clicked")
    }
    
    func setUIValues(){
        welcomeLabel.text = "Welcome"
        learningLabel.text = "Welcome"
        
    }
    
}

