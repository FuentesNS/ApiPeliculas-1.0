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


// MARK: - Welcome
struct UserProfile: Codable {
    let avatar: Avatar
    let id: Int
    let iso_639_1, iso_3166_1, name: String
    let include_adult: Bool
    let username: String

//    enum CodingKeys: String, CodingKey {
//        case avatar, id
//        case iso639_1 = "iso_639_1"
//        case iso3166_1 = "iso_3166_1"
//        case name
//        case includeAdult = "include_adult"
//        case username
//    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let gravatar: Gravatar
    let tmdb: Tmdb
}

// MARK: - Gravatar
struct Gravatar: Codable {
    let hash: Double
}

// MARK: - Tmdb
struct Tmdb: Codable {
    let avatar_path: String

//    enum CodingKeys: String, CodingKey {
//        case avatarPath = "avatar_path"
//    }
}
