//
//  Drink.swift
//  Barman
//
//  Created by Edgar Macias on 28/02/23.
//

import Foundation


/// Estructura que encapsula las propiedades de una bebida
struct Bebida: Codable {
    let directions: String
    let ingredients: String
    let name: String
    let img: String
}

typealias Bebidas = [Bebida]

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

