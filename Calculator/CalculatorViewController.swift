//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Cory Eighan on 2/25/16.
//  Copyright © 2016 HappyLife. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsTypingANumber = false
    var brain = CalculatorBrain()
    var decimalPlaced = false

    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if (userIsTypingANumber) {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if operation == "+/-" && userIsTypingANumber {
            displayValue = -displayValue
        }
        else {
            if userIsTypingANumber {
                enter()
            }
            if let result = brain.performOperation(operation) {
                displayValue = result
                history.text = history.text!.stringByReplacingOccurrencesOfString("=", withString: "")
                history.text = history.text! + operation + " ="
            }
            else {
                displayValue = 0 //have this work with nil aka optionals
            }
        }
    }

    @IBAction func enter() {
        if userIsTypingANumber {
            if let result = brain.pushOperand(displayValue) {
                displayValue = result
                history.text = history.text! + display.text! + " "
            }
        }
        userIsTypingANumber = false
    }

    @IBAction func decimalPoint(sender: UIButton) {
        if decimalPlaced == false {
            appendDigit(sender)
        }
        decimalPlaced = true
    }
    
    @IBAction func backspace() {
        
    }
    
    @IBAction func clear() {
        userIsTypingANumber = false
        decimalPlaced = false
        display.text = "0"
        history.text?.removeAll()
        brain.clearOps()
        
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = "\(newValue)"
        }
    }
}

