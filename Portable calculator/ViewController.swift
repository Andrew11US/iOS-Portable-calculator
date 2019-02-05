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
    @IBOutlet weak var bgView: UIView!
    
    // Animated view appearance
    @IBOutlet weak var modeBtn: UIButton!
    @IBOutlet weak var modeView: SpringView!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    var viewAppeared = false
    
    // Variables for calculations
    var runningNumber = "0"
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation = CalcService.Operation.empty
    
    // Feedback generator for haptic touch
    let impact = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = runningNumber
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    // Change bar style to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Hide modeView when tap outside the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideModeView()
    }
    
    @IBAction func numberPressed(_ btn: UIButton!) {
        
        if runningNumber != "0" {
            runningNumber += "\(btn.tag)"
            
        } else {
            runningNumber = ""
            runningNumber += "\(btn.tag)"
        }
        
        outputLabel.text = runningNumber
        hideModeView()
    }
    
    @IBAction func dotTapped(_ btn: UIButton!) {
        
        if runningNumber.contains(".") {
            debugPrint("Dot already exists in number!")
        } else {
            runningNumber += "."
            outputLabel.text = runningNumber
        }
        hideModeView()
    }
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.divide)
        firstOperand.text = CalcService.shared.trimZeroForInt(strNumber: leftValStr)
        operatorLbl.text = CalcService.Operation.divide.rawValue
        impact.impactOccurred()
        hideModeView()
    }
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.multiply)
        firstOperand.text = CalcService.shared.trimZeroForInt(strNumber: leftValStr)
        operatorLbl.text = CalcService.Operation.multiply.rawValue
        impact.impactOccurred()
        hideModeView()
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.subtract)
        firstOperand.text = CalcService.shared.trimZeroForInt(strNumber: leftValStr)
        operatorLbl.text = CalcService.Operation.subtract.rawValue
        impact.impactOccurred()
        hideModeView()
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.add)
        firstOperand.text = CalcService.shared.trimZeroForInt(strNumber: leftValStr)
        operatorLbl.text = CalcService.Operation.add.rawValue
        impact.impactOccurred()
        hideModeView()
    }
    
    @IBAction func signPressed(_ sender: AnyObject) {
        
        if let res = CalcService.shared.changeSign(strNum: runningNumber) {
            result = res
            runningNumber = res
            outputLabel.text = result
        } else {
            result = "0"
            print("Result is zero")
        }
        impact.impactOccurred()
        hideModeView()
    }
    
    @IBAction func percentPressed(_ sender: AnyObject) {
        
        if leftValStr != "" {
            if let res = CalcService.shared.percentDouble(base: leftValStr, value: runningNumber) {
                runningNumber = res
                outputLabel.text = runningNumber
            } else {
                result = "0"
                print("Result is zero")
            }
        } else {
            
            if let res = CalcService.shared.percentSingle(base: runningNumber) {
                runningNumber = res
                outputLabel.text = runningNumber
            } else {
                result = "0"
                print("Result is zero")
            }
        }
        impact.impactOccurred()
        hideModeView()
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        
        if currentOperation != CalcService.Operation.empty {
            processOperation(currentOperation)
            
            secondOperand.text = CalcService.shared.trimZeroForInt(strNumber: rightValStr)
            outputLabel.text = CalcService.shared.trimZeroForInt(strNumber: result)
        }
        impact.impactOccurred()
        hideModeView()
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
        impact.impactOccurred()
        hideModeView()
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
        hideModeView()
    }
    
    func processOperation(_ operation: CalcService.Operation) {
        
        if currentOperation != CalcService.Operation.empty {
            
            if runningNumber != "0" {
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
                
                //                leftValStr = result
                leftValStr = CalcService.shared.trimZeroForInt(strNumber: result)
                outputLabel.text = CalcService.shared.trimZeroForInt(strNumber: result)
                //                value = Double(result)!.round(to: 5)
                //                outputLabel.text = String(value.formattedWithSeparator)
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
    
    @IBAction func modeRevealTapped(_ sender: UIButton) {
        impact.impactOccurred()
        animateView()
    }
    
}

extension ViewController {
    
    func animateView() {
        if viewAppeared {
            setForDisappear()
            viewAppeared = false
        } else {
            setForAppear()
            viewAppeared = true
        }
        
        //  viewAppeared = viewAppeared ? false : true
        
        modeView.animate()
    }
    
    func setForAppear() {
        modeView.duration = 0.7
        modeView.animation = Spring.AnimationPreset.SlideDown.rawValue
        modeView.curve = Spring.AnimationCurve.EaseIn.rawValue
        constraint.constant = 100
    }
    
    func setForDisappear() {
        modeView.duration = 0.7
        modeView.animation = Spring.AnimationPreset.SlideUp.rawValue
        modeView.curve = Spring.AnimationCurve.EaseIn.rawValue
        constraint.constant = -200
    }
    
    func hideModeView() {
        if viewAppeared {
            animateView()
        }
    }
    
}

