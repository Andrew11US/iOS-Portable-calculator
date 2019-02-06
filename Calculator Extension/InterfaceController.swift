//
//  InterfaceController.swift
//  Calculator Extension
//
//  Created by Andrew on 2/6/19.
//  Copyright © 2019 Andrii Halabuda. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    // Outlets
    @IBOutlet weak var outputLbl: WKInterfaceLabel!
    @IBOutlet weak var addBtn: WKInterfaceButton!
    @IBOutlet weak var subtractBtn: WKInterfaceButton!
    @IBOutlet weak var multiplyBtn: WKInterfaceButton!
    @IBOutlet weak var divideBtn: WKInterfaceButton!
    @IBOutlet weak var dotBtn: WKInterfaceButton!
    @IBOutlet weak var equalsBtn: WKInterfaceButton!
    @IBOutlet weak var zeroBtn: WKInterfaceButton!
    @IBOutlet weak var oneBtn: WKInterfaceButton!
    @IBOutlet weak var twoBtn: WKInterfaceButton!
    @IBOutlet weak var threeBtn: WKInterfaceButton!
    @IBOutlet weak var fourBtn: WKInterfaceButton!
    @IBOutlet weak var fiveBtn: WKInterfaceButton!
    @IBOutlet weak var sixBtn: WKInterfaceButton!
    @IBOutlet weak var sevenBtn: WKInterfaceButton!
    @IBOutlet weak var eightBtn: WKInterfaceButton!
    @IBOutlet weak var nineBtn: WKInterfaceButton!
    
    // Variables for calculations
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation = CalcService.Operation.empty
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        outputLbl.setText(runningNumber)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func eraceOnTap(_ sender: Any) {
        print("Eraced!")
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = CalcService.Operation.empty
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func add(_ sender: Any) {
        processOperation(CalcService.Operation.add)
    }
    
    @IBAction func subtract(_ sender: Any) {
        processOperation(CalcService.Operation.subtract)
    }
    
    @IBAction func multiply(_ sender: Any) {
        processOperation(CalcService.Operation.multiply)
    }
    
    @IBAction func divide(_ sender: Any) {
        processOperation(CalcService.Operation.divide)
    }
    
    @IBAction func equals(_ sender: Any) {
        if currentOperation != CalcService.Operation.empty {
            processOperation(currentOperation)
            outputLbl.setText(CalcService.shared.trimZeroForInt(strNumber: result))
            
        }
    }
    
    @IBAction func dotTapped(_ sender: Any) {
        if runningNumber.contains(".") {
            debugPrint("Dot already exists in number!")
        } else {
            runningNumber += "."
            outputLbl.setText(runningNumber)
        }
    }
    
    @IBAction func zeroTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "0"
            
        } else {
            runningNumber = ""
            runningNumber += "0"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func oneTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "1"
            
        } else {
            runningNumber = ""
            runningNumber += "1"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func twoTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "2"
            
        } else {
            runningNumber = ""
            runningNumber += "2"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func threeTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "3"
            
        } else {
            runningNumber = ""
            runningNumber += "3"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func fourTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "4"
            
        } else {
            runningNumber = ""
            runningNumber += "4"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func fiveTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "5"
            
        } else {
            runningNumber = ""
            runningNumber += "5"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func sixTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "6"
            
        } else {
            runningNumber = ""
            runningNumber += "6"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func sevenTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "7"
            
        } else {
            runningNumber = ""
            runningNumber += "7"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func eightTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "8"
            
        } else {
            runningNumber = ""
            runningNumber += "8"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    @IBAction func nineTapped(_ sender: Any) {
        if runningNumber != "0" {
            runningNumber += "9"
            
        } else {
            runningNumber = ""
            runningNumber += "9"
        }
        
        outputLbl.setText(runningNumber)
    }
    
    func processOperation(_ operation: CalcService.Operation) {
        
        if currentOperation != CalcService.Operation.empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = "0"
                
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
                
                leftValStr = CalcService.shared.trimZeroForInt(strNumber: result)
                outputLbl.setText(CalcService.shared.trimZeroForInt(strNumber: result))
            }
            
            currentOperation = operation
            print("CO:", currentOperation)
            
        } else {
            
            // This is the first time operator was pressed
            leftValStr = runningNumber
            rightValStr = "0"
            runningNumber = "0"
            currentOperation = operation
        }
    }
    
    
}
