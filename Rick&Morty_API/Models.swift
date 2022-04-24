//
//  Models.swift
//  Rick&Morty_API
//
//  Created by Adam Khalifa on 15.04.2022.
//

import Foundation

struct Information: Codable {
    var count: Int
    var pages: Int
}

struct MainResponse: Codable {
    let results: [Character]
    var info: Information?
}

struct Character: Codable {
    let id: Int?
    let name: String
    let species: String
    let gender: String
    let location: Location
    let image: String
    let episode: [Episodes]
}

struct Location: Codable {
    let name: String
}

struct Episodes: Codable {
    
}
