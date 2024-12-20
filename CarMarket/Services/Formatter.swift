//
//  Formatter.swift
//  CarMarket
//
//  Created by Viktor Drykin on 19.12.2024.
//

import Foundation

enum Formatter {

    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyCode = "EUR"
        formatter.currencySymbol = "€"
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "DE")
        formatter.numberStyle = .currency
        return formatter
    }()

    static let monthAndYearDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter
    }()

    static let apiDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-yyyy"
        return dateFormatter
    }()

    static let measurement: MeasurementFormatter = {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.locale = Locale(identifier: "DE")
        return measurementFormatter
    }()
}
