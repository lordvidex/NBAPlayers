//
//  Team.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 27.01.2021.
//

import Foundation

struct Team: Decodable, Equatable {
    let name: String
    let city: String
    let conference: String
    let abbreviation: String
    var fullName : String {
        city + " " + name
    }
    
}
