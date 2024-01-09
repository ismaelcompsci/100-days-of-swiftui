//
//  Order.swift
//  CupcakeCorner
//
//  Created by Mirna Olvera on 1/8/24.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = "" {
        didSet {
            // save
            UserDefaults.standard.set(streetAddress, forKey: "address")
        }
    }

    var city = "" {
        didSet {
            // save
            UserDefaults.standard.set(city, forKey: "city")
        }
    }

    var zip = "" {
        didSet {
            // save
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        if isOnlyWhitespace(name) || isOnlyWhitespace(streetAddress) || isOnlyWhitespace(city) || isOnlyWhitespace(zip) {
            return false
        }

        return true
    }

    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity * 2)

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }

    init() {
        streetAddress = UserDefaults.standard.string(forKey: "address") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    }

    func isOnlyWhitespace(_ field: String) -> Bool {
        if field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }

        return false
    }
}
