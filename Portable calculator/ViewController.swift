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
//    @IBOutlet weak var modeBtn: UIButton!
//    @IBOutlet weak var modeView: SpringView!
    
    @IBOutlet weak var darkBtn: CustomButton!
    @IBOutlet weak var lightBtn: CustomButton!
    @IBOutlet weak var oledBtn: CustomButton!
    
    @IBOutlet weak var constraint: NSLayoutConstraint!
//    var viewAppeared = false
//    var currentScheme: Mode = .dark
    
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
        
//        retreiveDataFromDefaults()
        
//        modeView.layer.cornerRadius = 30
//        modeBtn.layer.cornerRadius = 25
        outputLabel.text = runningNumber
        
//        checkForColorScheme()
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    // Change bar style depending on color scheme
    private var statusBarForDarkScheme = true
    
    private func changeStatusBarColor() {
        statusBarForDarkScheme = !statusBarForDarkScheme
        setNeedsStatusBarAppearanceUpdate()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarForDarkScheme ? .lightContent : .default
    }
    
    
    // Hide modeView when tap outside the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        hideModeView()
    }
    
    @IBAction func numberPressed(_ btn: UIButton!) {
        
        if runningNumber != "0" {
            runningNumber += "\(btn.tag)"
            
        } else {
            runningNumber = ""
            runningNumber += "\(btn.tag)"
        }
        
        outputLabel.text = runningNumber
//        hideModeView()
    }
    
    @IBAction func dotTapped(_ btn: UIButton!) {
        if runningNumber == "" {
            runningNumber += "0."
            outputLabel.text = runningNumber
        } else if runningNumber.contains(".") {
            debugPrint("Dot already exists in number!")
        } else {
            runningNumber += "."
            outputLabel.text = runningNumber
        }
    }
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.divide)
        firstOperand.text = CalcService.shared.trimZeroForInt(strNumber: leftValStr)
        operatorLbl.text = CalcService.Operation.divide.rawValue
        impact.impactOccurred()
    }
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.multiply)
        firstOperand.text = CalcService.shared.trimZeroForInt(strNumber: leftValStr)
        operatorLbl.text = CalcService.Operation.multiply.rawValue
        impact.impactOccurred()
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.subtract)
        firstOperand.text = CalcService.shared.trimZeroForInt(strNumber: leftValStr)
        operatorLbl.text = CalcService.Operation.subtract.rawValue
        impact.impactOccurred()
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(CalcService.Operation.add)
        firstOperand.text = CalcService.shared.trimZeroForInt(strNumber: leftValStr)
        operatorLbl.text = CalcService.Operation.add.rawValue
        impact.impactOccurred()
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
//        hideModeView()
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        
        if currentOperation != CalcService.Operation.empty {
            processOperation(currentOperation)
            
            if rightValStr == "" {
                outputLabel.text = "Error"
            } else {
                secondOperand.text = CalcService.shared.trimZeroForInt(strNumber: rightValStr)
                outputLabel.text = CalcService.shared.trimZeroForInt(strNumber: result)
            }
            
        } else {
            debugPrint("Performing no action")
        }
        
       
        
        impact.impactOccurred()
//        hideModeView()
    }
    
    @IBAction func onClearPressed(_ sender: AnyObject) {
        
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = CalcService.Operation.empty
        
        outputLabel.text = "0"
        firstOperand.text = ""
        secondOperand.text = ""
        operatorLbl.text = ""
        impact.impactOccurred()
    }
    
    @IBAction func delTapped(_ sender: AnyObject) {
        
        if runningNumber != "" {
            
            runningNumber = String(runningNumber.dropLast())
            outputLabel.text = runningNumber
            
            if runningNumber == "" {
                runningNumber = ""
//                outputLabel.text = runningNumber
                outputLabel.text = "0"
            }
            
        } else {
            
            runningNumber = ""
            outputLabel.text = "0"
        }
        
        if runningNumber == "0" {
            outputLabel.text = "0"
        }
//        hideModeView()
    }
    
    func processOperation(_ operation: CalcService.Operation) {
        
        if currentOperation != CalcService.Operation.empty {
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
                
                leftValStr = CalcService.shared.trimZeroForInt(strNumber: result)
//                secondOperand.text = rightValStr
                outputLabel.text = CalcService.shared.trimZeroForInt(strNumber: result)
            } else {
                rightValStr = runningNumber
                secondOperand.text = rightValStr
            }
            
            currentOperation = operation
            print("CO:", currentOperation)
            
        } else {
            
            // This is the first time operator was pressed
            leftValStr = runningNumber
            rightValStr = ""
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    @IBAction func modeRevealTapped(_ sender: UIButton) {
        impact.impactOccurred()
//        animateView()
    }
    
    @IBAction func darkBtnTapped(_ sender: CustomButton) {
//        enableDarkScheme()
        impact.impactOccurred()
    }
    
    @IBAction func lightBtnTapped(_ sender: CustomButton) {
//        enableLightScheme()
        impact.impactOccurred()
    }
    
    @IBAction func oledBtnTapped(_ sender: CustomButton) {
//        enableOLEDscheme()
        impact.impactOccurred()
    }
    
}

//extension ViewController {
//
//    func animateView() {
//        if viewAppeared {
//            setForDisappear()
//            viewAppeared = false
//        } else {
//            setForAppear()
//            viewAppeared = true
//        }
//
//        //  viewAppeared = viewAppeared ? false : true
//
//        modeView.animate()
//    }
//
//    func setForAppear() {
//        modeView.duration = 1.0
//        modeView.animation = Spring.AnimationPreset.SlideDown.rawValue
//        modeView.curve = Spring.AnimationCurve.EaseIn.rawValue
//        constraint.constant = 60
//    }
//
//    func setForDisappear() {
//        modeView.duration = 1.0
//        modeView.animation = Spring.AnimationPreset.SlideUp.rawValue
//        modeView.curve = Spring.AnimationCurve.EaseIn.rawValue
//        constraint.constant = -240
//    }
//
//    func hideModeView() {
//        if viewAppeared {
//            animateView()
//        }
//    }
//
//    func retreiveDataFromDefaults() {
//        let temp = UserDefaults.standard.value(forKey: "colorScheme") as? String ?? "No data!"
//
//        switch temp {
//        case "light":
//            currentScheme = .light
//        case "dark":
//            currentScheme = .dark
//        case "oled":
//            currentScheme = .oled
//        default:
//            currentScheme = .dark
//        }
//    }
//
//    func checkForColorScheme() {
//        switch currentScheme {
//        case .light:
//            enableLightScheme()
//        case .dark:
//            enableDarkScheme()
//        case .oled:
//            enableOLEDscheme()
//        }
//    }
//
//    func enableLightScheme() {
//        bgView.layer.backgroundColor = UIColor.white.cgColor
//        outputLabel.textColor = UIColor(hex: "#4C505E")
//        firstOperand.textColor = UIColor(hex: "#4C505E")
//        secondOperand.textColor = UIColor(hex: "#4C505E")
//        clearButton.setTitleColor(UIColor(hex: "#4C505E"), for: .normal)
//        signBtn.setTitleColor(UIColor(hex: "#4C505E"), for: .normal)
//        percentBtn.setTitleColor(UIColor(hex: "#4C505E"), for: .normal)
//        modeBtn.setImage(UIImage(named: "Light-menu"), for: .normal)
//        modeView.layer.backgroundColor = UIColor(hex: "#4C505E").cgColor
//        currentScheme = .light
//
//        oledBtn.setImage(UIImage(named: "OLED"), for: .normal)
//        lightBtn.setImage(UIImage(named: "sLight"), for: .normal)
//        darkBtn.setImage(UIImage(named: "Dark"), for: .normal)
//
//        UserDefaults.standard.set(currentScheme.rawValue, forKey: "colorScheme")
//        debugPrint(UserDefaults.standard.value(forKey: "colorScheme") ?? "No data!")
//
//        lightBtn.layer.backgroundColor = UIColor.blue.cgColor
//        darkBtn.layer.backgroundColor = UIColor.clear.cgColor
//        oledBtn.layer.backgroundColor = UIColor.clear.cgColor
//
//        if statusBarForDarkScheme {
//            changeStatusBarColor()
//        }
//    }
//
//    func enableDarkScheme() {
//        bgView.layer.backgroundColor = UIColor(hex: "#4C505E").cgColor
//        outputLabel.textColor = UIColor.white
//        firstOperand.textColor = UIColor.white
//        secondOperand.textColor = UIColor.white
//        clearButton.setTitleColor(UIColor.white, for: .normal)
//        signBtn.setTitleColor(UIColor.white, for: .normal)
//        percentBtn.setTitleColor(UIColor.white, for: .normal)
//        modeBtn.setImage(UIImage(named: "Dark-menu"), for: .normal)
//        modeView.layer.backgroundColor = UIColor.white.cgColor
//        currentScheme = .dark
//
//        oledBtn.setImage(UIImage(named: "OLED"), for: .normal)
//        lightBtn.setImage(UIImage(named: "Light"), for: .normal)
//        darkBtn.setImage(UIImage(named: "sDark"), for: .normal)
//
//        UserDefaults.standard.set(currentScheme.rawValue, forKey: "colorScheme")
//        debugPrint(UserDefaults.standard.value(forKey: "colorScheme") ?? "No data!")
//
//        darkBtn.layer.backgroundColor = UIColor.blue.cgColor
//        lightBtn.layer.backgroundColor = UIColor.clear.cgColor
//        oledBtn.layer.backgroundColor = UIColor.clear.cgColor
//
//        if !statusBarForDarkScheme {
//            changeStatusBarColor()
//        }
//    }
//
//    func enableOLEDscheme() {
//        bgView.layer.backgroundColor = UIColor.black.cgColor
//        outputLabel.textColor = UIColor.white
//        firstOperand.textColor = UIColor.white
//        secondOperand.textColor = UIColor.white
//        clearButton.setTitleColor(UIColor.white, for: .normal)
//        signBtn.setTitleColor(UIColor.white, for: .normal)
//        percentBtn.setTitleColor(UIColor.white, for: .normal)
//        modeBtn.setImage(UIImage(named: "OLED-menu"), for: .normal)
//        modeView.layer.backgroundColor = UIColor.white.cgColor
//        currentScheme = .oled
//
//        oledBtn.setImage(UIImage(named: "sOLED"), for: .normal)
//        lightBtn.setImage(UIImage(named: "Light"), for: .normal)
//        darkBtn.setImage(UIImage(named: "Dark"), for: .normal)
//
//        UserDefaults.standard.set(currentScheme.rawValue, forKey: "colorScheme")
//        debugPrint(UserDefaults.standard.value(forKey: "colorScheme") ?? "No data!")
//
//        if !statusBarForDarkScheme {
//            changeStatusBarColor()
//        }
//    }
//
//}

