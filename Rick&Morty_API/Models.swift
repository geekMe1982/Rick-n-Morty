//
//  Models.swift
//  Rick&Morty_API
//
//  Created by Adam Khalifa on 15.04.2022.
//

import Foundation

struct APIResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: String
    let name: String
    let species: String
    let gender: String
    let location: theLocation
    let image: String
    let episode: [episodes]
}

struct theLocation: Codable {
    let name: String
}

struct episodes: Codable {
    
}
