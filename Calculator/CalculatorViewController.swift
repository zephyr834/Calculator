//
//  ViewController.swift
//  Calculator
//
//  Created by Cory Eighan on 2/25/16.
//  Copyright © 2016 HappyLife. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
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
        if userIsTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            }
            else {
                displayValue = 0
            }
        }

    }

    @IBAction func enter() {
        userIsTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }
        else {
            displayValue = 0
        }
    }

    @IBAction func decimalPoint(sender: UIButton) {
        if decimalPlaced == false {
            appendDigit(sender)
        }
        decimalPlaced = true
    }
    
    @IBAction func clear(sender: AnyObject) {
        userIsTypingANumber = false
        decimalPlaced = false
        display.text = "0"
        
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

