//
//  Token.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 16/11/22.
//

import Foundation

struct DataToken: Codable{
    let tokenApi: Token
}

struct TokenUser: Codable{
    let tokenApi: UserData
}

struct Token: Codable {
    let success: Bool
    let expires_at: String
    let request_token: String
    
    
}

struct UserData: Codable {
    let usernam: String
    let password: String
    let request_token: String
}

