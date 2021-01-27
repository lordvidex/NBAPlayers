//
//  GamesViewController.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 27.01.2021.
//

import UIKit

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    let apiClient: ApiClient = ApiClientImpl()
    @IBOutlet weak var reloadBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var gamesTableView: UITableView!
    var games: [Game] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "GameDetailsViewController") as! GameDetailsViewController
        let game: Game = games[indexPath.row]
        viewController.game = game
        
        navigationController?.pushViewController(viewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! GameTableViewCell
        let game: Game = games[indexPath.row]
        cell.homeName.text = game.homeTeam.name
        cell.awayName.text = game.awayTeam.name
        cell.timeLabel.text = game.formattedDate
        cell.statusLabel.text = game.status
        cell.awayScore.text = String(game.awayScore!)
        cell.homeScore.text = String(game.homeScore!)
        cell.setColorOfTeams(game)
        cell.game = game
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Games"
        getGames()
    }
    private func showError(){
        self.loadingIndicator.stopAnimating()
        errorLabel.isHidden = false
        reloadBtn.isHidden = false
        
    }
    @IBAction func onReloadBtnPressed(_ sender: Any) {
        getGames()
    }
    private func showData(){
        errorLabel.isHidden = true
        reloadBtn.isHidden = true
        loadingIndicator.stopAnimating()
    }
    private func showLoading(){
        errorLabel.isHidden = true
        reloadBtn.isHidden = true
        self.loadingIndicator.startAnimating()
    }
    private func getGames(){
        showLoading()
        apiClient.getGames(completion: { result in
            DispatchQueue.main.async {
                switch(result){
                case .failure:
                    self.games = []
                    self.showError()
                case .success(let games):
                    self.games = games
                    self.showData()
                }
                self.gamesTableView.reloadData()
            }
        })
    }

}
