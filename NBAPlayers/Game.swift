//
//  Game.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 27.01.2021.
//

import Foundation

struct GamesResponse: Decodable {
    let data: [Game]
}
struct Game: Decodable {
    let status: String
    let homeTeam: Team
    let awayTeam: Team
    let homeScore: Int?
    let awayScore: Int?
    let date: String
    let postseason: Bool
    let season: Int
    
    enum CodingKeys: String, CodingKey {
        case season = "season"
        case homeScore = "home_team_score"
        case awayScore = "visitor_team_score"
        case date = "date"
        case homeTeam = "home_team"
        case awayTeam = "visitor_team"
        case status = "status"
        case postseason = "postseason"
    }
    var formattedDate: String{
        let dateFormatterGet = DateFormatter()
        let dateFormatterPrint = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        dateFormatterPrint.dateFormat = "MM/dd/yyyy"
        if let fromDate = dateFormatterGet.date(from: date){
            return dateFormatterPrint.string(from: fromDate)
        }else {
            return "-"
        }
    }
    // home team score
    // away team score
    // home team data
    // away team data
    // date
    //formatted date
}
