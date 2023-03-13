//
//  MovieVM.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 02/03/2023.
//

import Foundation

protocol HomeDelegate: AnyObject {
    func success()
    func error(error: String)
}

final class HomeVM {
        
    var movies: [Movie] = []
    weak var delegate: HomeDelegate?
    var page = 1
    
    func getMovie() {
        MovieService.shared.getMovies(page: page) { [weak self] response, errorMessage in
            guard let self = self else { return }
            
            if let response = response {
                self.movies.append(contentsOf: response.results)
                self.page += 1
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
    
    func searchMovie(query: String) {
        SearchService.shared.searchMovie(page: page, query: query) { [weak self] response, errorMessage in
            guard let self = self else { return }
            
            if let response = response {
                self.movies = response.results
                self.delegate?.success()
            } else {
                self.delegate?.error(error: errorMessage ?? "Something went wrong.")
            }
        }
    }
}
