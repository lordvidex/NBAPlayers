//
//  Player.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 27.01.2021.
//

import Foundation

struct PlayersResponse : Decodable{
    let data : [Player]
}
struct Player : Decodable {
    let firstName: String
    let lastName: String
    let team: Team
    let heightFeet: Int?
    let heightInches: Int?
    let position: String
    
    var height: String {
        if let heightFeet = heightFeet, let heightInches = heightInches {
            return "\(heightFeet)'\(heightInches)''"
        }else{
            return "Unknown"
        }
    }
    var fullName: String {
        firstName+" "+lastName
    }
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case position = "position"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case team = "team"
    }
}

