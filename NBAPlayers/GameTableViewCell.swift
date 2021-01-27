//
//  GameTableViewCell.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 27.01.2021.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var game: Game?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setColorOfTeams(_ game: Game){
        if(game.homeScore ?? 0 > game.awayScore ?? 0){
            homeScore.textColor = UIColor.green
            awayScore.textColor = UIColor.red
        }else if(game.homeScore ?? 0 < game.awayScore ?? 0){
            awayScore.textColor = UIColor.green
            homeScore.textColor = UIColor.red
        }else{
            homeScore.textColor = UIColor.systemYellow
            awayScore.textColor = UIColor.systemYellow
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
