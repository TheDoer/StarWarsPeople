//
//  PeopleModel.swift
//  StarWarsPeople
//
//  Created by Adonis Rumbwere on 13/10/2021.
//

import Foundation


struct APIResponse: Codable {
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let height: String?
    let mass: String?
    let hairColor: String?
    let skinColor: String?
    let eyeColor: String?
    let birthYear: String?
    let gender: String?
    let homeworld: String?

    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor
        case skinColor
        case eyeColor
        case birthYear
        case gender
        case homeworld
    }
}
