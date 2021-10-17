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
    let hair_color: String?
    let skin_color: String?
    let eye_color: String?
    let birth_year: String?
    let gender: String?
    let homeworld: String?
}
