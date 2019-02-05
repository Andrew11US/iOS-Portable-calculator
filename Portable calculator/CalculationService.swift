//
//  CalculationService.swift
//
//  Created by Andrii Halabuda on 5/31/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import UIKit

struct CalcService {
    
    static let shared = CalcService()
    
    enum Operation: String {
        case divide = "÷"
        case multiply = "×"
        case subtract = "−"
        case add = "+"
        case sign = "#"
        case empty = ""
    }
    
    func multiply(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            let temp = "\(numA * numB)"
            return trimZeroForInt(strNumber: temp)
        } else {
            return nil
        }
    }
    
    func subtract(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            let temp = "\(numA - numB)"
            return trimZeroForInt(strNumber: temp)
        } else {
            return nil
        }
    }
    
    func divide(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            let temp = "\(numA / numB)"
            return trimZeroForInt(strNumber: temp)
        } else {
            return nil
        }
    }
    
    func add(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            let temp = "\(numA + numB)"
            return trimZeroForInt(strNumber: temp)
        } else {
            return nil
        }
    }
    
    func changeSign(strNum: String) -> String? {
        
        if let numA = Double(strNum) {
            let temp = numA == 0 ? "0" : "\(-numA)"
            return trimZeroForInt(strNumber: temp)
        } else {
            return nil
        }
    }
    
    func percentSingle(base: String) -> String? {
        if let numA = Double(base) {
            let temp = "\(numA * 0.01)"
            return trimZeroForInt(strNumber: temp)
        } else {
            return nil
        }
    }
    
    func percentDouble(base: String, value: String) -> String? {
        if let numA = Double(base), let numB = Double(value) {
            let temp = "\(numA * numB * 0.01)"
            return trimZeroForInt(strNumber: temp)
        } else {
            return nil
        }
    }
    
    func trimZeroForInt(strNumber: String) -> String {
        if strNumber.hasSuffix(".") {
            print(strNumber.dropLast(1))
            return String(strNumber.dropLast(1))
        } else if strNumber.hasSuffix(".0") {
            print(strNumber.dropLast(2))
            return String(strNumber.dropLast(2))
        } else {
            return strNumber
        }
    }
    
}

