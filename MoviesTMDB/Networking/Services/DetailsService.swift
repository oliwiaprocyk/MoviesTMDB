//
//  DetailsService.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 02/03/2023.
//

import Foundation

class DetailsService {
    static let shared = DetailsService()
    private init(){}
    
    func getDetails(movieID: Int, completion: @escaping((DetailsModel?, String?) -> ())) {
        let urlString = "\(APIConstants.baseURL)\(APIConstants.detailEndPoint)\(movieID)?api_key=\(APIConstants.apiKey)"
        
        NetworkManager.shared.request(type: DetailsModel.self,
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
    
    
    
    
