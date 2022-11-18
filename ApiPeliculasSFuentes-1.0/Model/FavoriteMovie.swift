//
//  Movie.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 16/11/22.
//

import Foundation

// MARK: - Welcome
struct DataMovie: Codable {
    let page: Int
    let results: [ResultFavoriteMovie]
    let total_pages, total_results: Int

}

// MARK: - Result
struct ResultFavoriteMovie: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language, original_title, overview: String
    let popularity: Double
    let poster_path, release_date, title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int

}

