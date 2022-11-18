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
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbar.delegate = self
        MoviesCollectionView.delegate = self
        MoviesCollectionView.dataSource = self
        self.MoviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesViewCell")
        
        
        //print("User session id in base controller \(String(describing: userId!))")
        
        //        GetAllFavoriteMovie(ResultCompletionHandler: {result, error in
        //            if let result = result {
        //                if result.Correct!{
        //                    let userProfile = result.Object as! UserProfile
        //
        //                    let json = userProfile.id
        //                    print(json)
        //                }
        //            }
        //        })
        
    }
    
    //    func GetAllFavoriteMovie(ResultCompletionHandler: @escaping (Result?, Error?) -> Void?){
    //
    //        let result = Result()
    //
    //
    //        let url = URL(string:"https://\(userId!)")
    //
    //        URLSession.shared.dataTask(with: url!) { data, response, error in
    //            if let _ = error {
    //                print("Error")
    //            }
    //
    //            if let data = data,
    //               let httpResponse = response as? HTTPURLResponse,
    //               httpResponse.statusCode == 200 {
    //
    //                do{
    //                    let tasks = try JSONDecoder().decode(UserProfile.self, from: data)
    //
    //                    print(tasks)
    //
    //                    result.Object = tasks
    //
    //                    result.Correct = true
    //
    //                    ResultCompletionHandler(result, nil)
    //
    //                }catch let parseErr{
    //                    print(error)
    //                    print("JSON Parsing Error", parseErr)
    //                    ResultCompletionHandler(nil, parseErr)
    //                }
    //            }
    //        }.resume()
    //    }
    
    
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
