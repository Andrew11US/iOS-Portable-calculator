//
//  CalculationService.swift
//
//  Created by Andrii Halabuda on 5/31/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import UIKit

class CalcService {
    
    static let shared = CalcService()
    
    enum Operation: String {
        case divide = "÷"
        case multiply = "×"
        case subtract = "−"
        case add = "+"
        case root = "√"
        case percent = "%"
        case empty = ""
    }
    
    func multiply(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            return "\(numA * numB)"
        } else {
            return nil
        }
    }
    
    func subtract(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            return "\(numA - numB)"
        } else {
            return nil
        }
    }
    
    func divide(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            return "\(numA / numB)"
        } else {
            return nil
        }
    }
    
    func add(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            return "\(numA + numB)"
        } else {
            return nil
        }
    }
    
    func root(numAstr: String) -> String? {
        
        if let numA = Double(numAstr) {
            return "\(sqrt(numA))"
        } else {
            return nil
        }
    }
    
    func percent(numAstr: String, numBstr: String) -> String? {
        
        if let numA = Double(numAstr), let numB = Double(numBstr) {
            return "\(numA + numB * 0.01)"
        } else {
            return nil
        }
    }
}

