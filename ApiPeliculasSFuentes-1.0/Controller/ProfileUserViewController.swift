//
//  ProfileUserViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 17/11/22.
//

import UIKit

class ProfileUserViewController: UIViewController {

    @IBOutlet weak var ImageProfile: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    
    let sessionId = UserDefaults.standard.string(forKey: "SessionId")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("User session id in base controller \(String(describing: sessionId!))")
        
        GetDataProfileUser(ResultCompletionHandler: {result, error in
            if let result = result {
                if result.Correct!{
                    let userProfile = result.Object as! UserProfile
                    
                    let json = userProfile.id
                    print(json)
                    
                    DispatchQueue.main.async {
                        if let url = URL( string:"https://image.tmdb.org/t/p/w64_and_h64_face/\(userProfile.avatar.tmdb.avatar_path)")
                        {
                            print(url)
                            DispatchQueue.global().async {
                                
                                if let data = try? Data( contentsOf:url)
                                {
                                    DispatchQueue.main.async {
                                        self.ImageProfile.image = UIImage( data:data)
                                        self.UserName.text = userProfile.username
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        })
        
        
        
        GetAllFavoriteMovie(ResultCompletionHandler: {result, error in
            if let result = result {
                if result.Correct!{
                    let userProfile = result.Object as! DataMovie

                    let json = userProfile.results
                    print(json)
                }
            }
        })
    }
    
    
    func GetDataProfileUser(ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
        
        let result = Result()

        
        let url = URL(string:"https://api.themoviedb.org/3/account?api_key=583dbd688a1811cd5bc8fad24a69b65f&session_id=\(sessionId!)")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                
                do{
                    let tasks = try JSONDecoder().decode(UserProfile.self, from: data)
                    
                    print(tasks)
                    
                    result.Object = tasks
                    
                    result.Correct = true
                    
                    let userProfile = result.Object as! UserProfile
                    
                    let UserId = userProfile.id
                    print("Id de usuario \(UserId)")
                    
                    UserDefaults.standard.set(UserId, forKey:"UserId");
                    UserDefaults.standard.synchronize();
                    
                    ResultCompletionHandler(result, nil)
                    
                }catch let parseErr{
                    print(error)
                    print("JSON Parsing Error", parseErr)
                    ResultCompletionHandler(nil, parseErr)
                }
            }
        }.resume()
    }

    
    
    
        func GetAllFavoriteMovie(ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
    
            let userId = UserDefaults.standard.integer(forKey: "UserId")

            
            let result = Result()
    
    
            let url = URL(string:"https://api.themoviedb.org/3/account/\(userId)/favorite/movies?api_key=583dbd688a1811cd5bc8fad24a69b65f&session_id=\(sessionId!)")
    
            URLSession.shared.dataTask(with: url!) { data, response, error in
                if let _ = error {
                    print("Error")
                }
    
                if let data = data,
                   let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
    
                    do{
                        let tasks = try JSONDecoder().decode(DataMovie.self, from: data)
    
                        print(tasks)
    
                        result.Object = tasks
    
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
