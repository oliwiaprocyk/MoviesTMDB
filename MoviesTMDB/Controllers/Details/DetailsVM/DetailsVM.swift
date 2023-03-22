//
//  DetailsVM.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 02/03/2023.
//

import Foundation

protocol DetailDelegate: AnyObject {
    func startActivityIndicator()
    func setup(movie: DetailsModel)
    func error(error: String)
}
final class DetailsVM {
    weak var delegate: DetailDelegate?
    
    func getDetail(movieID: Int) {
        self.delegate?.startActivityIndicator()
        DetailsService.shared.getDetails(movieID: movieID) { [weak self] response, errorMessage in
            guard let self = self else { return }
            
            if let response = response {
                self.delegate?.setup(movie: response)
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
}
