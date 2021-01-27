//
//  PlayerDetailsViewController.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 26.01.2021.
//

import UIKit

class PlayerDetailsViewController: UIViewController {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var heightLabel: UILabel!
    var player: Player?
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        navigationItem.title = player?.fullName
        navigationController?.navigationBar.prefersLargeTitles = true
        positionLabel.text = player?.position
        heightLabel.text = player?.height
        teamButton.setTitle(player?.team.fullName, for: .normal)
    }

    @IBAction func onTeamButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let viewcontroller = storyBoard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController
        viewcontroller.team = player?.team
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
}
