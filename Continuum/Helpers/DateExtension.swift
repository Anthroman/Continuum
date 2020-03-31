//
//  DateExtension.swift
//  Continuum
//
//  Created by Anthroman on 3/31/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation

extension Date {
    
    var formatted: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
