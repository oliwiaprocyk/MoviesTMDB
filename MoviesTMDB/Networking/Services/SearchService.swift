//
//  SearchService.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 03/03/2023.
//

import Foundation

class SearchService {
    static let shared = SearchService()
    private init(){}
    
    func searchMovie(page: Int, query: String, completion: @escaping((MovieModel?, String?) -> ())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.searchEndPoint)?api_key=\(APIConstants.apiKey)&query=\(query)&page=\(page)"
        
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
