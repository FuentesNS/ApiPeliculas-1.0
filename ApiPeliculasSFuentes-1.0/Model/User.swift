//
//  User.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 16/11/22.
//

import Foundation

struct User{
    var Email: String
    var Password: String
}

struct SessionUser: Codable{
    let session_id: String
    let success: Bool
  }

// MARK: - UserProfile
struct ProfileUser: Codable {
    let avatar: Avatar
    let id: Int
    let iso_639_1, iso_3166_1, name: String
    let include_adult: Bool
    let username: String

}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar
    let tmdb: Tmdb
}

// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: String
}

// MARK: - Tmdb
struct Tmdb: Codable {
    let avatar_path: String

}
