//
//  BaseViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 16/11/22.
//

import UIKit

class BaseViewController: UIViewController{
    
    let userId = UserDefaults.standard.string(forKey: "UserId")
    let sessionId = UserDefaults.standard.string(forKey: "SessionId")
    
    let idMovie = 0
    
    @IBOutlet weak var tabbar: UITabBar!
    @IBOutlet weak var MoviesCollectionView: UICollectionView!
    
    var popularMovies: DataMovie?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbar.delegate = self
//        self.tabbar.items![1].present = true
        self.tabbar.tag = 1
        
        self.tabbar.selectedItem = tabbar.items?.first
        
        MoviesCollectionView.delegate = self
        MoviesCollectionView.dataSource = self
        self.MoviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesViewCell")
        
        LoadData()
        

        print("Este es el Id de la cuenta \(String(describing: userId!))")
        print("Este es el Id de la session \(String(describing: sessionId!))")
    }
    
    
    func LoadData(){
        do{
            GetAllPupularMovie(ResultCompletionHandler: {result, error in
                if let result = result {
                    if result.Correct!{
                        self.popularMovies = result.Object as? DataMovie
                        
                        let json = self.popularMovies
                        print(json as Any)
                        
                        DispatchQueue.main.async {
                            self.MoviesCollectionView.reloadData()
                        }
                    }
                }
            })
        }catch{
            print("Ocurrio un error")
        }
    }
    
    
    func GetAllPupularMovie(ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
        
        let result = Result()
        
        
        let url = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=583dbd688a1811cd5bc8fad24a69b65f&language=en-US&page=1")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                
                do{
                    let popularMovies = try JSONDecoder().decode(DataMovie.self, from: data)
                    
                    print(popularMovies)
                    
                    result.Object = popularMovies
                    
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
    
    
    
    func GetAllNowPlayingMovie(ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
        
        let result = Result()
        
        
        let url = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=583dbd688a1811cd5bc8fad24a69b65f&language=en-US&page=1")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data,
               let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                
                do{
                    let popularMovies = try JSONDecoder().decode(DataMovie.self, from: data)
                    
                    print(popularMovies)
                    
                    result.Object = popularMovies
                    
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
    


extension BaseViewController: UITabBarDelegate {

    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        //This method will be called when user changes tab.
        //item.index(ofAccessibilityElement: 1)
//        item.title = "Po"
        //tem.isEnabled = true
        
        //tabBar.selectedItem = tabBar.items[item.tag] as? UITabBarItem
        
//        tabBar.tag = 0
//        tabBar.selectedItem = tabBar.items?[item.tag] as? UITabBarItem

        if(item.tag == 1) {

            // Code for item 1
            print("One")

        }
        else if(item.tag == 2) {
            // Code for item 2
            print("two")
            LoadData()

        } else if(item.tag == 3) {
            // Code for item 3
            print("three")

        }else if(item.tag == 4) {
            // Code for item 4
            print("four")

        }

    }
}




extension BaseViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesViewCell", for: indexPath) as! MoviesCollectionViewCell

        let popularMovie = self.popularMovies?.results[indexPath.row]
        

        cell.NameMovie.text = popularMovie?.original_title
        cell.CalfMovie.text = String(describing:("★\((popularMovie!.vote_average * 10).rounded()/10)"))
        cell.DescriptionMovie.text = popularMovie?.overview
        
        
        print(popularMovie!.poster_path)
        
        
        DispatchQueue.main.async {
            print(popularMovie!.vote_average)
//            print(populateMovie)
            if let url = URL(string:"https://image.tmdb.org/t/p/w600_and_h900_bestv2\(String(describing:popularMovie!.poster_path))")
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
    
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        //print("You selected cell #\(indexPath.item)!")
//        var popularMovies = self.popularMovies?.results[indexPath.row]
//
//        self.performSegue(withIdentifier: "AreaSegues", sender: self)
//
//        return true
//
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "AreaSegues"{
//
//            let popularMovie = self.popularMovies?.results[Int]
//
//            if let vc = segue.destination as? MoviesCollectionViewCell {
//                //DepartamentoViewController?.IdArea = self.area.IdArea!
//                vc.idMovie = self.popularMovie?.results[1].id
//            }
//        }
//    }

    
}
