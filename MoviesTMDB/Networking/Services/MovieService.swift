//
//  MovieService.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 02/03/2023.
//

import Foundation

class MovieService {
    static let shared = MovieService()
    private init(){}
    
    func getMovies(page: Int, completion: @escaping((MovieModel?, String?) -> ())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.movieEndPoint)?api_key=\(APIConstants.apiKey)&page=\(page)"
        
        NetworkManager.shared.request(type: MovieModel.self,
                                      url: urlString,
                                      method: HTTPMethods.get) { response in
            
            switch response{
            case .success(let items):
                completion(items,nil)
            case .failure(let error):
                completion(nil,error.rawValue)
            }
        }
    }
}
