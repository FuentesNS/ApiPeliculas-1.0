//
//  Movie.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 16/11/22.
//

import Foundation

let userId = UserDefaults.standard.string(forKey: "UserId")
let sessionId = UserDefaults.standard.string(forKey: "SessionId")
var result = Result()

// MARK: - Welcome
struct DataMovie: Codable {
    let page: Int
    let results: [ResultDataMovie]
    let total_pages, total_results: Int

}

// MARK: - Result
struct ResultDataMovie: Codable {
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

struct FavoriteMovie{
    let mediaType: String
    let mediaID: Int
    let favorite: Bool
}

struct ResponseMovie: Codable{
    let status_code: Int
    let status_message: String
}



class PetitionMovies {
    
    
    func AddMovieFavorite(_ IdMovie: Int, ResultCompletionHandler: @escaping (Result?, Error?) -> Void){
        
        // prepare json data
        let parameter = ["media_type": "movie", "media_id": IdMovie, "favorite": true] as [String : Any]
        
        //create the url with NSURL
        let url = URL(string: "https://api.themoviedb.org/3/account/\(String(describing: userId!))/favorite?api_key=583dbd688a1811cd5bc8fad24a69b65f&session_id=\(String(describing: sessionId!))")
        print(url)
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        var request = URLRequest(url: url!)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            //completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                ResultCompletionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                ResultCompletionHandler(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            
            do {
                let responseHttp = HTTPURLResponse()
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    //completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                print(json)
                
                
                if responseHttp.statusCode == 200{
                    print("Se puede realizar token")
                    result.Correct = true
                    do{
                        let tasks = try JSONDecoder().decode(ResponseMovie.self, from: data)
                        
                        print(tasks)
                        
                        result.Object = tasks
                        
                        result.Correct = true
                        
                        ResultCompletionHandler(result, nil)
                        
                    }catch let parseErr{
                        print(error as Any)
                        print("JSON Parsing Error", parseErr)
                        ResultCompletionHandler(nil, parseErr)
                    }
                } else if responseHttp.statusCode == 400 {
                    print("No se puede realizar token")
                    ResultCompletionHandler(result, nil)
                }
            } catch let error {
                print(error.localizedDescription)
                ResultCompletionHandler(nil, error)
            }
        })
        
        task.resume()
    }
    
    
}
