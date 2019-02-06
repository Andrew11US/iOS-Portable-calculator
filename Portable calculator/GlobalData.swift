//
//  GlobalData.swift
//  Portable calculator
//
//  Created by Andrew on 2/5/19.
//  Copyright © 2019 Andrii Halabuda. All rights reserved.
//

import Foundation
import UIKit

let colorSchemeStored = UserDefaults.standard.string(forKey: "colorSchemeStored")

enum Mode: String, CaseIterable {
    case dark = "dark"
    case light = "light"
    case oled = "oled"
}
