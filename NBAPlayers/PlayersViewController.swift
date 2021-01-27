//
//  PlayersViewController.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 26.01.2021.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var reloadBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var players: [Player] = []
    let apiClient: ApiClient = ApiClientImpl()
        
    override func viewDidLoad() {
        navigationItem.title = "Players"
        navigationController?.navigationBar.prefersLargeTitles = true
            getPlayers()
        super.viewDidLoad()
    }
    private func getPlayers(){
        showLoading()
        apiClient.getPlayers(completion: { result in
            DispatchQueue.main.async {
                switch(result){
                case .failure:
                    self.players = []
                    self.showError()
                case .success(let players):
                    self.players = players
                    self.showData()
                }
                self.playersTableView.reloadData()
            }
        })
    }
    @IBAction func onReloadBtnPressed(_ sender: Any) {
        getPlayers()
    }
    private func showLoading() {
        errorLabel.isHidden = true;
        reloadBtn.isHidden = true;
        activityIndicator.startAnimating()
    }
    private func showError(){
        errorLabel.isHidden = false;
        reloadBtn.isHidden = false;
        activityIndicator.stopAnimating()
    }
    private func showData(){
        errorLabel.isHidden = true;
        reloadBtn.isHidden = true;
        activityIndicator.stopAnimating()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        let player: Player = players[indexPath.row]
        
        cell.textLabel?.text = player.fullName
        cell.detailTextLabel?.text = player.team.fullName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let viewController = storyboard.instantiateViewController(identifier: "PlayerDetailsViewController") as! PlayerDetailsViewController
        let player: Player = players[indexPath.row]
        viewController.player = player
        
        navigationController?.pushViewController(viewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
