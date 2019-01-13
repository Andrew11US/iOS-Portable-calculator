//
//  ViewController.swift
//  Portable calculator
//
//  Created by Andrew on 1/12/19.
//  Copyright © 2019 Andrii Halabuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var delButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var keyboard: UIStackView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var percentBtn: UIButton!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var firstOperand: UILabel!
    @IBOutlet weak var secondOperand: UILabel!
    @IBOutlet weak var operatorLbl: UILabel!
    @IBOutlet weak var modeBtn: UIButton!
    
    // Variables for calculations
    var runningNumber = "0"
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var value = 0.0
    var currentOperation = CalcService.Operation.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = value.round(to: 5).formattedWithSeparator
    }
    
    //******************************
    //***Calculator functionality***
    //******************************
    
    @IBAction func numberPressed(_ btn: UIButton!) {
        
        if runningNumber != "0" {
            runningNumber += "\(btn.tag)"
            
        } else {
            runningNumber = ""
            runningNumber += "\(btn.tag)"
        }
        
        outputLabel.text = runningNumber
        
        if let num = Double(runningNumber) {
            value = num
        }
    }
    
    @IBAction func dotTapped(_ btn: UIButton!) {
        
        if runningNumber.contains(".") {
            debugPrint("Dot already exists in number!")
        } else {
            runningNumber += "."
            outputLabel.text = runningNumber
        }
        
        if let num = Double(runningNumber) {
            value = num
        } else {
            debugPrint("Error occured in converting string value!")
        }
        
    }
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.divide)
        firstOperand.text = leftValStr
        operatorLbl.text = CalcService.Operation.divide.rawValue
    }
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.multiply)
        firstOperand.text = leftValStr
        operatorLbl.text = CalcService.Operation.multiply.rawValue
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.subtract)
        firstOperand.text = leftValStr
        operatorLbl.text = CalcService.Operation.subtract.rawValue
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.add)
        firstOperand.text = leftValStr
        operatorLbl.text = CalcService.Operation.add.rawValue
    }
    
    @IBAction func signPressed(_ sender: AnyObject) {
        
        if let num = Double(runningNumber) {
            if num != 0 {
                runningNumber = String(-num)
                result = String(-num)
                value = Double(result)!.round(to: 5)
                outputLabel.text = String(value.formattedWithSeparator)
            } else {
                runningNumber = "0"
                result = "0"
                value = Double(result)!.round(to: 5)
                outputLabel.text = String(value.formattedWithSeparator)
            }
            
        }
    }
    
    @IBAction func percentPressed(_ sender: AnyObject) {
        
        if let num = Double(leftValStr), let num2 = Double(runningNumber) {
            runningNumber = String(num * num2 * 0.01)
            result = String(num * num2 * 0.01)
            value = Double(result)!.round(to: 5)
            outputLabel.text = String(value.formattedWithSeparator)
            
        } else if let num = Double(runningNumber) {
            runningNumber = String(num * 0.01)
            result = String(num * 0.01)
            value = Double(result)!.round(to: 5)
            outputLabel.text = String(value.formattedWithSeparator)
        }
        
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        
        if currentOperation != CalcService.Operation.empty {
            processOperation(currentOperation)
            
            secondOperand.text = rightValStr
            outputLabel.text = String(value.round(to: 5).formattedWithSeparator)
        }
//        processOperation(currentOperation)
//
//        secondOperand.text = rightValStr
//        outputLabel.text = String(value.round(to: 5).formattedWithSeparator)
    }
    
    @IBAction func onClearPressed(_ sender: AnyObject) {
        
        runningNumber = "0"
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = CalcService.Operation.empty
        
        outputLabel.text = "0"
        firstOperand.text = ""
        secondOperand.text = ""
        operatorLbl.text = ""
        value = 0.0
    }
    
    @IBAction func delTapped(_ sender: AnyObject) {
        
        if runningNumber != "" {
            
            runningNumber = String(runningNumber.dropLast())
            outputLabel.text = runningNumber
            
            if runningNumber == "" {
                runningNumber = "0"
                outputLabel.text = runningNumber
            }
            
        } else {
            
            runningNumber = "0"
            outputLabel.text = ""
        }
        
        if runningNumber == "0" {
            outputLabel.text = "0"
        }
    }
    
    func processOperation(_ operation: CalcService.Operation) {
        
        if currentOperation != CalcService.Operation.empty {
            
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == CalcService.Operation.multiply {
                    if let res = CalcService.shared.multiply(numAstr: leftValStr, numBstr: rightValStr) {
                        result = res
                    } else {
                        result = "0"
                        print("NO return value")
                    }
                    
                } else if currentOperation == CalcService.Operation.divide {
                    if let res = CalcService.shared.divide(numAstr: leftValStr, numBstr: rightValStr) {
                        result = res
                    } else {
                        result = "0"
                        print("NO return value")
                    }
                    
                } else if currentOperation == CalcService.Operation.subtract {
                    if let res = CalcService.shared.subtract(numAstr: leftValStr, numBstr: rightValStr) {
                        result = res
                    } else {
                        result = "0"
                        print("NO return value")
                    }
                    
                } else if currentOperation == CalcService.Operation.add {
                    if let res = CalcService.shared.add(numAstr: leftValStr, numBstr: rightValStr) {
                        result = res
                    } else {
                        result = "0"
                        print("NO return value")
                    }
                }
                
                leftValStr = result
                value = Double(result)!.round(to: 5)
                outputLabel.text = String(value.formattedWithSeparator)
            }
            
            currentOperation = operation
            print("CO:", currentOperation)
            
        } else {
            
            // This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = "0"
            currentOperation = operation
        }
    }


}

