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
    
    @IBOutlet weak var FavoriteMovieCollectionView: UICollectionView!
    
    
    var favoritesMovies: DataMovie?
    
    
    let sessionId = UserDefaults.standard.string(forKey: "SessionId")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("User session id in base controller \(String(describing: sessionId!))")
        
        FavoriteMovieCollectionView.delegate = self
        FavoriteMovieCollectionView.dataSource = self
        self.FavoriteMovieCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesViewCell")
        
        
        GetDataProfileUser(ResultCompletionHandler: {result, error in
            if let result = result {
                if result.Correct!{
                    let userProfile = result.Object as! ProfileUser
                    
                    let json = userProfile.id
                    print("photo del usuario \(userProfile.avatar.tmdb.avatar_path)")
                    //print(json)
                    
                    DispatchQueue.main.async {
                        if let url = URL( string:"https://image.tmdb.org/t/p/w64_and_h64_face\(userProfile.avatar.tmdb.avatar_path)")
                        {
                            print(userProfile.avatar.tmdb.avatar_path)
                            DispatchQueue.global().async {
                                
                                if let data = try? Data( contentsOf:url)
                                {
                                    DispatchQueue.main.async {
                                        self.ImageProfile.image = UIImage( data:data)
                                        self.UserName.text = userProfile.username
                                        
                                        UserDefaults.standard.set(userProfile.id, forKey:"UserId");
                                        UserDefaults.standard.synchronize();
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        })
        
        
    LoadData()
    
    }
    
    func LoadData(){
        do{
            GetAllFavoriteMovie(ResultCompletionHandler: {result, error in
                if let result = result {
                    if result.Correct!{
                        self.favoritesMovies = result.Object as? DataMovie
                        
                        let json = self.favoritesMovies
                        print(json as Any)
                        
                        DispatchQueue.main.async {
                            self.FavoriteMovieCollectionView.reloadData()
                        }
                    }
                }
            })
        }catch{
            print("Ocurrio un error")
        }
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
                    var json = try? JSONSerialization.jsonObject(with: data)
                    print(json)
                    let tasks = try JSONDecoder().decode(ProfileUser.self, from: data)
                    result.Object = tasks
                    
                    result.Correct = true
                    
                    let userProfile = result.Object as! ProfileUser
                    
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

extension ProfileUserViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesMovies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        let favoriteMovie = self.favoritesMovies?.results[indexPath.row]

        
        
        cell.NameMovie.text = favoriteMovie?.original_title
        //cell.DateMovie.text = favoriteMovie?.
        //let populateMovie = (favoriteMovie!.vote_average * 10).rounded()/10
        cell.CalfMovie.text = String(describing:("★\((favoriteMovie!.vote_average * 10).rounded()/10)"))
        cell.DescriptionMovie.text = favoriteMovie?.overview
        print(favoriteMovie!.poster_path)
        DispatchQueue.main.async {
            print(favoriteMovie!.vote_average)
//            print(populateMovie)
            if let url = URL(string:"https://image.tmdb.org/t/p/w1280\(String(describing:favoriteMovie!.poster_path))")
            {
                print(url)
                DispatchQueue.global().async {

                    if let data = try? Data( contentsOf:url)
                    {
                        DispatchQueue.main.async {
                            cell.PhotoMovie.image = UIImage( data:data)
                        }
                    }
                }
            }
        }
        cell.backgroundColor = .green
        
        return cell
        
    }
}
