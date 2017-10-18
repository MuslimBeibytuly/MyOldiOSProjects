//
//  ViewController.swift
//  calculator
//
//  Created by user on 8/23/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var calculator : Calculator!
    
    @IBOutlet weak var inputTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        calculator = Calculator()
    }
    
    @IBAction func numberClicked(_ sender: UIButton) {
        inputTextField.text = inputTextField.text! + sender.titleLabel!.text!
    }
    @IBAction func operationClicked(_ sender: UIButton) {
        let operation = Character(sender.titleLabel!.text!)
        switch operation{
        case "C":
            calculator.clear()
            inputTextField.text = ""
            break
        case "=":
            calculator.secondOperand = Float(inputTextField.text!)!
            inputTextField.text = String(calculator.calculate())
            break
        case "+", "-", "/", "*":
            if(inputTextField.hasText){
                calculator.firstOperand = Float(inputTextField.text!)!
                calculator.operation = operation
            }
            inputTextField.text = ""
            break
        case "~":
            inputTextField.text = "-" + inputTextField.text!
            break
        case "%":
            inputTextField.text = String(Float(inputTextField.text!)! / 100.0)
            break
        default:
            break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
