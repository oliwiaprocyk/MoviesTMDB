//
//  DetailsModel.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 24/02/2023.
//

import Foundation

struct DetailsModel: Codable {
    let title: String?
    let overview: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
    }
}
