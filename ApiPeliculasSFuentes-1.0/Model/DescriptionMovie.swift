//
//  DescriptionMovie.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 30/11/22.
//

import Foundation

struct DescriptionMovie: Codable{
    let adult: Bool
    let backdrop_path: String
    let belongs_to_collection: BelongsToCollection?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdb_id, original_language, original_title, overview: String
    let popularity: Double
    let poster_path: String
    let production_companies: [ProductionCompany]
    let production_countries: [ProductionCountry]
    let release_date: String
    let revenue, runtime: Int
    let spoken_languages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

struct BelongsToCollection: Codable{
    let id: Int?
    let name, poster_path, backdrop_path: String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logo_path: String?
    let name, origin_country: String
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso_3166_1, name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage : Codable{
    let english_name, iso_639_1, name: String
}


class GetDataOfMovie{
    
    func GetByIdDataMovie(_ IdMovie: Int, ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
        
        let result = Result()
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(IdMovie)?api_key=583dbd688a1811cd5bc8fad24a69b65f&language=en-US")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                
                do{
                    let topRatedMovie = try JSONDecoder().decode(DescriptionMovie.self, from: data)
                    
                    print(topRatedMovie)
                    
                    result.Object = topRatedMovie
                    
                    result.Correct = true
                    
                    ResultCompletionHandler(result, nil)
                    
                }catch let parseErr{
                    print("Intento de debugueo")
                    print(parseErr.localizedDescription)
                    print("JSON Parsing Error", parseErr)
                    ResultCompletionHandler(nil, parseErr)
                }
            }
        }.resume()
    }
}

