//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct MonetaryAmount: Codable, Equatable, Hashable {
    public let amount: String
    public let currency: String

    public var decimalAmount: Decimal? {
        NumberFormatters.decimalNumberFormatter.number(from: amount)?.decimalValue
    }

    public var formatted: String {
        NumberFormatters.currencyFormatter.string(for: decimalAmount)!
    }

    public init(amount: String, currency: String) {
        self.amount = amount
        self.currency = currency
    }
}

extension MonetaryAmount: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        guard let amount = NumberFormatters.decimalNumberFormatter.string(for: value)
//            let currency = Locale.autoupdatingCurrent.currencySymbol
        else {
            fatalError("Value \(value) not expressible as Monetary amount")
        }

        self.init(amount: amount, currency: "EUR")
    }

    public init(decimalValue value: Decimal) {
        self.init(floatLiteral: (value as NSDecimalNumber).doubleValue)
    }
}

// MARK: - Operations
extension MonetaryAmount: Comparable {
    // MARK: Compare
    public static func < (lhs: MonetaryAmount, rhs: MonetaryAmount) -> Bool {
        guard let lhsAmount = lhs.decimalAmount, let rhsAmount = rhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return lhsAmount < rhsAmount
    }

    public static func < (lhs: MonetaryAmount, rhs: Int) -> Bool {
        guard let lhsAmount = lhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return lhsAmount < Decimal(rhs)
    }

    public static func < (lhs: Int, rhs: MonetaryAmount) -> Bool {
        guard let rhsAmount = rhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return Decimal(lhs) < rhsAmount
    }

    public static func > (lhs: MonetaryAmount, rhs: MonetaryAmount) -> Bool {
        guard let lhsAmount = lhs.decimalAmount, let rhsAmount = rhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return lhsAmount > rhsAmount
    }

    public static func > (lhs: MonetaryAmount, rhs: Int) -> Bool {
        guard let lhsAmount = lhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return lhsAmount > Decimal(rhs)
    }

    public static func > (lhs: Int, rhs: MonetaryAmount) -> Bool {
        guard let rhsAmount = rhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return Decimal(lhs) > rhsAmount
    }

    public static func == (lhs: MonetaryAmount, rhs: MonetaryAmount) -> Bool {
        guard let lhsAmount = lhs.decimalAmount, let rhsAmount = rhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return lhsAmount == rhsAmount
    }

    public static func == (lhs: MonetaryAmount, rhs: Int) -> Bool {
        guard let lhsAmount = lhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return lhsAmount == Decimal(rhs)
    }

    public static func == (lhs: Int, rhs: MonetaryAmount) -> Bool {
        guard let rhsAmount = rhs.decimalAmount else {
            preconditionFailure("Can't compare invalid MonetaryAmounts")
        }

        return Decimal(lhs) == rhsAmount
    }

    private static func execute(operation: (Decimal, Decimal) -> Decimal,
                                lhs: MonetaryAmount,
                                rhs: MonetaryAmount) -> MonetaryAmount {
        guard
            let lhsAmount = lhs.decimalAmount,
            let rhsAmount = rhs.decimalAmount,
            lhs.currency == rhs.currency
        else {
            preconditionFailure("Can't operate on invalid MonetaryAmounts")
        }

        let result = operation(lhsAmount, rhsAmount)

        guard let decimalString = NumberFormatters.decimalNumberFormatter.string(for: result) else {
            preconditionFailure("Can't turn into decimal")
        }

        return .init(amount: decimalString, currency: lhs.currency)
    }

    private static func execute(operation: (Decimal, Decimal) -> Decimal,
                                lhs: MonetaryAmount,
                                rhs: Int) -> MonetaryAmount {
        execute(operation: operation, lhs: lhs, rhs: MonetaryAmount(amount: rhs.description, currency: lhs.currency))
    }

    private static func execute(operation: (Decimal, Decimal) -> Decimal,
                                lhs: Int,
                                rhs: MonetaryAmount) -> MonetaryAmount {
        execute(operation: operation, lhs: MonetaryAmount(amount: lhs.description, currency: rhs.currency), rhs: rhs)
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
