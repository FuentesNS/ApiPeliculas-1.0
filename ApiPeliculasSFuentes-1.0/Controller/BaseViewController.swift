//
//  BaseViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 16/11/22.
//

import UIKit

class BaseViewController: UIViewController{
    
    @IBOutlet weak var tabbar: UITabBar!
    @IBOutlet weak var MoviesCollectionView: UICollectionView!
    
    var IdSession: Int = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbar.delegate = self
        MoviesCollectionView.delegate = self
        self.MoviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesViewCell")
        
        // Do any additional setup after loading the view.
        
        func GetAllFavoriteMovie(ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
            
            let result = Result()

//            var result1: [T.Type: Any] = [:]
            //var DataUser = [String: String]()
            
            
            let url = URL(string:"https://api.themoviedb.org/3/account?api_key=583dbd688a1811cd5bc8fad24a69b65f&session_id=\(IdSession)")
            
            URLSession.shared.dataTask(with: url!) { data, response, error in
                if let _ = error {
                    print("Error")
                }
                
                if let data = data,
                   let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    
                    do{
                        let tasks = try JSONDecoder().decode(UserProfile.self, from: data)
                        
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
    }
}
    


extension BaseViewController: UITabBarDelegate {


    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.

        if(item.tag == 1) {
            // Code for item 1
            print("One")
        }
        else if(item.tag == 2) {
            // Code for item 2
            print("two")

        } else if(item.tag == 3) {
            // Code for item 2
            print("three")

        }else if(item.tag == 4) {
            // Code for item 2
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesViewCell", for: indexPath) as! MoviesCollectionViewCell

        cell.backgroundColor = .green
        
        return cell

    }
    

    
}
