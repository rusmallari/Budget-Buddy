//
//  Extensions.swift
//  CPSC362_test
//
//  Created by csuftitan on 10/13/23.
//

import Foundation

extension Date {
    func day(calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(.day, from: self)
    }
    func month(calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(.month, from: self)
    }
    func year(calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(.year, from: self)
    }
}
