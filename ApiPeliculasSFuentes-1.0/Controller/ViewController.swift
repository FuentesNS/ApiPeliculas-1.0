//
//  ViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 16/11/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var EmailInput: UITextField!
    @IBOutlet weak var PasswordInput: UITextField!
    
    var result = Result()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


    
    @IBAction func SingInButton(_ sender: UIButton) {
        
        let user: User
        
        user = User(Email: EmailInput.text!, Password: PasswordInput.text!)
        
        //print(user)
        
        //ValidateToken(user.Email, user.Password)
        ValidateToken(user.Email, user.Password, ResultCompletionHandler: {result, error in
            if let result = result {
                //                print("user first name is : \(result.Object!)")
                //                print("user first name is : \(result.Correct!)")
                
                if result.Correct!{
                    
                    let userToken = result.Object as! Token
                    
                    let json = ["request_token": userToken.request_token]
                    
                    //create the url with NSURL

                    let url = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=583dbd688a1811cd5bc8fad24a69b65f")!
                    
                    //create the session object
                    let session = URLSession.shared
                    
                    //now create the Request object using the url object
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST" //set http method as POST
                    
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) // pass dictionary to data object and set it as request body
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
                            //completion(nil, error)
                            return
                        }
                        
                        guard let data = data else {
                            //completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
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
                                print("Se puede iniciar sesion")
                                result.Correct = true
                                do{
                                    let tasks = try JSONDecoder().decode(SessionUser.self, from: data)
                                    
                                    
                                    
                                    result.Object = tasks
                                    
                                    result.Correct = true
                                    
                                    print(result.Object)
                                    self.SendIdSession()
                                    
                                    //ResultCompletionHandler(result, nil)
                                    
                                }catch let parseErr{
                                    print(error)
                                    print("JSON Parsing Error", parseErr)
                                    //ResultCompletionHandler(nil, parseErr)
                                }
                            } else if responseHttp.statusCode == 400 {
                                print("No se puede realizar token")
                                //ResultCompletionHandler(result, nil)
                            }
                        } catch let error {
                            print(error.localizedDescription)
                            //ResultCompletionHandler(nil, error)
                        }
                    })
                    
                    task.resume()
                }
            }
        })
        
        
       
    }
    
    
    func SendIdSession(){
        let user: User
        
        user = User(Email: EmailInput.text!, Password: PasswordInput.text!)
        
        //print(user)
        
        //ValidateToken(user.Email, user.Password)
        ValidateToken(user.Email, user.Password, ResultCompletionHandler: {result, error in
            if let result = result {
                //                print("user first name is : \(result.Object!)")
                //                print("user first name is : \(result.Correct!)")
                
                if result.Correct!{
                    let user = result.Object as! SessionUser
                    print(user.session_id)
                    
                }
            }
        })
    }
    
    func ValidateToken(_ Email: String, _ Password: String, ResultCompletionHandler: @escaping (Result?, Error?) -> Void){
        
        
        GetTokenOfUser(ResultCompletionHandler: {result, error in
            if let result = result {
                //                print("user first name is : \(result.Object!)")
                //                print("user first name is : \(result.Correct!)")
                
                if result.Correct!{
                    let userToken = result.Object as! Token
                    
                    // prepare json data
                    let json = ["username": Email, "password": Password, "request_token": userToken.request_token]
                    
                    //create the url with NSURL
                    let url = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=583dbd688a1811cd5bc8fad24a69b65f")!
                    
                    //create the session object
                    let session = URLSession.shared
                    
                    //now create the Request object using the url object
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST" //set http method as POST
                    
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) // pass dictionary to data object and set it as request body
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
                                    let tasks = try JSONDecoder().decode(Token.self, from: data)
                                    
                                    print(tasks)
                                    
                                    result.Object = tasks
                                    
                                    result.Correct = true
                                    
                                    ResultCompletionHandler(result, nil)
                                    
                                }catch let parseErr{
                                    print(error)
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
        })
    }
    
    
    func GetTokenOfUser(ResultCompletionHandler: @escaping (Result?, Error?) -> Void){
        
        let result = Result()
        
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=583dbd688a1811cd5bc8fad24a69b65f")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                
                do{
                    let tasks = try JSONDecoder().decode(Token.self, from: data)
                    
//                    print(tasks.request_token)
//                    print(tasks.expires_at)
//                    print(tasks.success)
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
    
    
    func callAPI(){
        guard let url = URL(string: "https://api.themovied.org/3/authentication/token/new?api_key=583dbd688a1811cd5bc8fad24a69b65f") else{
            return
        }


        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
            }
        }

        task.resume()
    }
}



