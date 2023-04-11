//
//  MovieCell.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 23/02/2023.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLable: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    func setCell(with model: Movie) {
        self.titleMovieLable.text = model.title
        self.overviewLabel.text = model.overview
        
        if let path = model.posterPath {
            let url = URL(string: "http://image.tmdb.org/t/p/w500\(path)")
            self.movieImageView.kf.setImage(with: url)
        }
    }
}
