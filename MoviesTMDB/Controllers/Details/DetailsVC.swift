//
//  DetailsVC.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 23/02/2023.
//

import UIKit

final class DetailsVC: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    private var movieID: Int?
    private var viewModel = DetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        if let movieID = movieID {
            viewModel.getDetail(movieID: movieID)
        }
    }
    
    func getID(id: Int) {
        movieID = id
    }
}

extension DetailsVC: DetailDelegate {
    func error(error: String) {
        let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setup(movie: DetailsModel) {
        DispatchQueue.main.async {
            let imageURL = "https://image.tmdb.org/t/p/w500\(movie.posterPath)"
            
            self.titleMovieLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            self.movieImageView.downloaded(from: imageURL)
        }
    }
}