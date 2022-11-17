//
//  ProfileUserViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 17/11/22.
//

import UIKit

class ProfileUserViewController: UIViewController {

    
    
    let userId = UserDefaults.standard.string(forKey: "userId")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("User session id in base controller \(String(describing: userId!))")
        
        GetDataProfileUser(ResultCompletionHandler: {result, error in
            if let result = result {
                if result.Correct!{
                    let userProfile = result.Object as! UserProfile
                    
                    let json = userProfile.id
                    print(json)
                }
            }
        })
    }
    
    
    func GetDataProfileUser(ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
        
        let result = Result()

        
        let url = URL(string:"https://api.themoviedb.org/3/account?api_key=583dbd688a1811cd5bc8fad24a69b65f&session_id=\(userId!)")
        
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
