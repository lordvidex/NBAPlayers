//
//  GameDetailsViewController.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 27.01.2021.
//

import UIKit

class GameDetailsViewController: UIViewController {
    var game: Game?
    
    @IBOutlet weak var currentTeamScore: UILabel!
    @IBOutlet weak var winningTeamScore: UILabel!
    @IBOutlet weak var currentTeamName: UILabel!
    @IBOutlet weak var postSeasonLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    private func setUpInitialValues(){
        currentTeamName.text = game?.homeTeam.name
        currentTeamScore.text = "\(game?.homeScore ?? 0)"
        winningTeamScore.text = "\(max(game?.homeScore ?? 0, game?.awayScore ?? 0))"
        postSeasonLabel.text = (game?.postseason ?? false) ? "Yes" : "No"
        timeLabel.text = "Unknown"
        dateLabel.text = game?.formattedDate
        seasonLabel.text = "\(game?.season ?? 2001)"
        statusLabel.text = game?.status
        currentTeamScore.textColor = (game?.homeScore ?? 0 > game?.awayScore ?? 0) ? UIColor.green : UIColor.red
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialValues()
       navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "\(game?.homeTeam.abbreviation ?? "Home") vs \(game?.awayTeam.abbreviation ?? "Away")"
    }
    @IBAction func onTeamButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewcontroller = storyboard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController
        
       
        switch segmentedController.selectedSegmentIndex {
        
        case 0:
            viewcontroller.team = game?.homeTeam
        default:
            viewcontroller.team = game?.awayTeam
        }
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    @IBAction func indexChanged(_ sender: Any) {
        var selectedTeam: Team?
        switch segmentedController.selectedSegmentIndex {
        case 0:
            selectedTeam = game?.homeTeam
            currentTeamScore.textColor = (game?.homeScore ?? 0 > game?.awayScore ?? 0) ? UIColor.green : UIColor.red
        default:
            selectedTeam = game?.awayTeam
            currentTeamScore.textColor = (game?.homeScore ?? 0 > game?.awayScore ?? 0) ? UIColor.red : UIColor.green
        }
        currentTeamName.text = selectedTeam?.name
        currentTeamScore.text = selectedTeam == game?.homeTeam ? "\(game?.homeScore ?? 0)" : "\(game?.awayScore ?? 0)"
        teamButton.setTitle("View \(selectedTeam?.name ?? "")", for: .normal)
    }
}
