//
//  Popular.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by Samuel Fuentes Navarrete on 27/11/22.
//

import Foundation

struct Popular: Codable{
    let page: Int
    let results: [ResultPopular]
    let total_pages, total_results: Int
}

// MARK: - Result
struct ResultPopular: Codable {
    let backdrop_path, first_air_date: String
    let genre_ids: [Int]
    let id: Int
    let name: String
    let origin_country: [String]
    let original_language, original_name, overview: String
    let popularity: Double
    let poster_path: String
    let vote_average: Double
    let vote_count: Int
}


class WhatsPopular{
    func GetAllWhatsPopularMovie(ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
        
        let result = Result()
        let url = URL(string:"https://api.themoviedb.org/3/tv/popular?api_key=583dbd688a1811cd5bc8fad24a69b65f&language=en-US&page=1")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                
                do{
                    let topRatedMovie = try JSONDecoder().decode(Popular.self, from: data)
                    
                    print(topRatedMovie)
                    
                    result.Object = topRatedMovie
                    
                    result.Correct = true
                    
                    ResultCompletionHandler(result, nil)
                    
                }catch let parseErr{
                    print(error)
                    print("JSON Parsing Error", parseErr)
                    ResultCompletionHandler(nil, parseErr)
                }
            }
        }.resume()
    }
}
