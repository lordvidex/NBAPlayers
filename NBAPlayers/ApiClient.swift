//
//  ApiClient.swift
//  NBAPlayers
//
//  Created by Evans Owamoyo on 27.01.2021.
//

import Foundation

enum ApiError : Error{
    case noData
}

protocol ApiClient {
    func getPlayers(completion: @escaping (Result<[Player],Error>) -> ())
    func getGames(completion: @escaping (Result<[Game],Error>) -> ())
}
class ApiClientImpl: ApiClient{
    func getPlayers(completion: @escaping (Result<[Player], Error>) -> ()) {
        let session = URLSession.shared
        
        let url = URL(string: "https://www.balldontlie.io/api/v1/players")!
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(PlayersResponse.self, from: data)
                return completion(.success(response.data))
            } catch(let error) {
                print(error)
                return completion(.failure(error))
            }
        })
        
        dataTask.resume()
    }
    func getGames(completion: @escaping (Result<[Game], Error>) -> ()) {
        let session = URLSession.shared
        
        let url = URL(string: "https://www.balldontlie.io/api/v1/games")!
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(GamesResponse.self, from: data)
                return completion(.success(response.data))
            } catch(let error) {
                print(error)
                return completion(.failure(error))
            }
        })
        
        dataTask.resume()
    }
}
