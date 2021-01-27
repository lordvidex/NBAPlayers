//
//  TeamDetailsViewController.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 27.01.2021.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    @IBOutlet weak var conferenceLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    var team: Team?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = team?.name
        conferenceLabel.text = team?.conference
        cityNameLabel.text = team?.city
        
    }
    
}
