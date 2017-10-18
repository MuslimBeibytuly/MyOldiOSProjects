//
//  Calculator.swift
//  calculator
//
//  Created by user on 8/23/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class Calculator: NSObject {
    var firstOperand: Float
    var secondOperand: Float
    var operation: Character
    override init(){
        firstOperand = 0.0
        secondOperand = 0.0
        operation = " "
    }
    
    func clear(){
        firstOperand = 0.0
        secondOperand = 0.0
        operation = " "
    }
    
    func calculate() -> Float{
        switch operation{
        case "+":
            return firstOperand + secondOperand
        case "-":
            return firstOperand - secondOperand
        case "*":
            return firstOperand * secondOperand
        case "-":
            return firstOperand - secondOperand
        default:
            return 0.0
        }
    }
}
