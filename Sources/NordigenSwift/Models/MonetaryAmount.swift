//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct MonetaryAmount: Codable, Equatable, Hashable {
    public let amount: String
    public let currency: String
    public var decimalValue: Decimal {
        if let nsDecimal = NumberFormatters.decimalNumberFormatterDotSeparated.number(from: amount) as? NSDecimalNumber {
            return nsDecimal.decimalValue
        } else if let nsDecimal = NumberFormatters.decimalNumberFormatterCommaSeparated.number(from: amount) as? NSDecimalNumber {
            return nsDecimal.decimalValue
        } else {
            preconditionFailure("Amount(\(amount)) is not a valid decimal number")
        }
    }
    
    public init(amount: String, currency: String) {
        self.amount = amount
        self.currency = currency
    }
}

extension MonetaryAmount: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        let amount = String(format: "%f", value)
        var currencyCode: String = "EUR"
        if #available(iOS 16.0, *) {
            currencyCode = Locale.autoupdatingCurrent.currency?.identifier ?? currencyCode
        } else {
            currencyCode = Locale.autoupdatingCurrent.currencyCode ?? currencyCode
        }

        self.init(amount: amount, currency: currencyCode)
    }

    public init(decimalValue value: Decimal) {
        self.init(floatLiteral: (value as NSDecimalNumber).doubleValue)
    }
}

// MARK: - Operations
extension MonetaryAmount: Comparable {
    // MARK: Compare
    public static func < (lhs: MonetaryAmount, rhs: MonetaryAmount) -> Bool {
        lhs.decimalValue < rhs.decimalValue
    }

    public static func < (lhs: MonetaryAmount, rhs: Int) -> Bool {
        lhs.decimalValue < Decimal(rhs)
    }

    public static func < (lhs: Int, rhs: MonetaryAmount) -> Bool {
        Decimal(lhs) < rhs.decimalValue
    }

    public static func > (lhs: MonetaryAmount, rhs: MonetaryAmount) -> Bool {
        lhs.decimalValue > rhs.decimalValue
    }

    public static func > (lhs: MonetaryAmount, rhs: Int) -> Bool {
        lhs.decimalValue > Decimal(rhs)
    }

    public static func > (lhs: Int, rhs: MonetaryAmount) -> Bool {
        Decimal(lhs) > rhs.decimalValue
    }

    public static func == (lhs: MonetaryAmount, rhs: MonetaryAmount) -> Bool {
        lhs.decimalValue == rhs.decimalValue
    }

    public static func == (lhs: MonetaryAmount, rhs: Int) -> Bool {
        lhs.decimalValue == Decimal(rhs)
    }

    public static func == (lhs: Int, rhs: MonetaryAmount) -> Bool {
        Decimal(lhs) == rhs.decimalValue
    }

    private static func execute(operation: (Decimal, Decimal) -> Decimal,
                                lhs: MonetaryAmount,
                                rhs: MonetaryAmount) -> MonetaryAmount {
        guard lhs.currency == rhs.currency else {
            preconditionFailure("Can't operate on different currencies")
        }

        let result = operation(lhs.decimalValue, rhs.decimalValue)
        return .init(amount: result.formatted(.number), currency: lhs.currency)
    }

    private static func execute(operation: (Decimal, Decimal) -> Decimal,
                                lhs: MonetaryAmount,
                                rhs: Int) -> MonetaryAmount {
        execute(operation: operation, lhs: lhs, rhs: MonetaryAmount(amount: rhs.description, currency: lhs.currency))
    }

    private static func execute(operation: (Decimal, Decimal) -> Decimal,
                                lhs: Int,
                                rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: operation, lhs: MonetaryAmount(amount: lhs.formatted(.number), currency: rhs.currency), rhs: rhs)
    }

    // MARK: Add
    public static func + (lhs: MonetaryAmount, rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: +, lhs: lhs, rhs: rhs)
    }

    public static func += (lhs: inout MonetaryAmount, rhs: MonetaryAmount) {
        lhs = lhs + rhs
    }

    public static func + (lhs: MonetaryAmount, rhs: Int) -> MonetaryAmount {
        execute(operation: +, lhs: lhs, rhs: rhs)
    }

    public static func += (lhs: inout MonetaryAmount, rhs: Int) {
        lhs = lhs + rhs
    }

    public static func + (lhs: Int, rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: +, lhs: lhs, rhs: rhs)
    }

    // MARK: Substract
    public static func - (lhs: MonetaryAmount, rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: -, lhs: lhs, rhs: rhs)
    }

    public static func -= (lhs: inout MonetaryAmount, rhs: MonetaryAmount) {
        lhs = lhs - rhs
    }

    public static func - (lhs: MonetaryAmount, rhs: Int) -> MonetaryAmount {
        execute(operation: -, lhs: lhs, rhs: rhs)
    }

    public static func -= (lhs: inout MonetaryAmount, rhs: Int) {
        lhs = lhs - rhs
    }

    public static func - (lhs: Int, rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: -, lhs: lhs, rhs: rhs)
    }

    // MARK: Multiply
    public static func * (lhs: MonetaryAmount, rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: *, lhs: lhs, rhs: rhs)
    }

    public static func *= (lhs: inout MonetaryAmount, rhs: MonetaryAmount) {
        lhs = lhs * rhs
    }

    public static func * (lhs: MonetaryAmount, rhs: Int) -> MonetaryAmount {
        execute(operation: *, lhs: lhs, rhs: rhs)
    }

    public static func *= (lhs: inout MonetaryAmount, rhs: Int) {
        lhs = lhs * rhs
    }

    public static func * (lhs: Int, rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: *, lhs: lhs, rhs: rhs)
    }

    // MARK: Divide
    public static func / (lhs: MonetaryAmount, rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: /, lhs: lhs, rhs: rhs)
    }

    public static func /= (lhs: inout MonetaryAmount, rhs: MonetaryAmount) {
        lhs = lhs / rhs
    }

    public static func / (lhs: MonetaryAmount, rhs: Int) -> MonetaryAmount {
        execute(operation: /, lhs: lhs, rhs: rhs)
    }

    public static func /= (lhs: inout MonetaryAmount, rhs: Int) {
        lhs = lhs / rhs
    }

    public static func / (lhs: Int, rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: /, lhs: lhs, rhs: rhs)
    }
}
