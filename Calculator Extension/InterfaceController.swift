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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
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
        print("Tapped!")
    }
    
    @IBAction func add(_ sender: Any) {
        
    }
    
    @IBAction func subtract(_ sender: Any) {
        
    }
    
    @IBAction func multiply(_ sender: Any) {
        
    }
    
    @IBAction func divide(_ sender: Any) {
        
    }
    
    @IBAction func equals(_ sender: Any) {
        
    }
    
    @IBAction func dotTapped(_ sender: Any) {
        
    }
    
    @IBAction func zeroTapped(_ sender: Any) {
        
    }
    
    @IBAction func oneTapped(_ sender: Any) {
        
    }
    
    @IBAction func twoTapped(_ sender: Any) {
        
    }
    
    @IBAction func threeTapped(_ sender: Any) {
        
    }
    
    @IBAction func fourTapped(_ sender: Any) {
        
    }
    
    @IBAction func fiveTapped(_ sender: Any) {
        
    }
    
    @IBAction func sixTapped(_ sender: Any) {
        
    }
    
    @IBAction func sevenTapped(_ sender: Any) {
        
    }
    
    @IBAction func eightTapped(_ sender: Any) {
        
    }
    
    @IBAction func nineTapped(_ sender: Any) {
        
    }
    

}
