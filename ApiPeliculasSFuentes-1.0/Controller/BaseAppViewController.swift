//
//  TestViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 24/11/22.
//

import UIKit

class BaseAppViewController: UIViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var TrendingCollectionView: UICollectionView!
    @IBOutlet weak var WhatsPoularCollectionView: UICollectionView!
    
    @IBOutlet weak var TabBarOfBaseApp: UITabBar!
    
    var Movies: DataMovie?
    var PoluarMovies: Popular?
    var petitonOfMovieBaseApp = PetitionsOfMoviesBaseApp()
    var whatsPopular = WhatsPopular()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ScrollView.canCancelContentTouches = true
        self.ScrollView.delaysContentTouches = true
        
        
        TrendingCollectionView.delegate = self
        TrendingCollectionView.dataSource = self
        self.TrendingCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        
        
        WhatsPoularCollectionView.delegate = self
        WhatsPoularCollectionView.dataSource = self
        self.WhatsPoularCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        
        TabBarOfBaseApp.delegate = self
        
//        self.TabBarOfBaseApp.tag = 1
//        self.TabBarOfBaseApp.selectedItem = TabBarOfBaseApp.items?[1]
        
        LoadTrendingMovies()
        LoadWhatsPopularMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.TabBarOfBaseApp.tag = 1
        self.TabBarOfBaseApp.selectedItem = TabBarOfBaseApp.items?[1]
        print("Funcion will apper ejecutandose")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.TabBarOfBaseApp.tag = 1
//        self.TabBarOfBaseApp.selectedItem = TabBarOfBaseApp.items?[1]
//        print("Funcion did apper ejecutandose")
//
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func LoadTrendingMovies(){
        do{
            self.petitonOfMovieBaseApp.GetAllTrendingMovieOfTodey(ResultCompletionHandler: {result, error in
                if let result = result {
                    if result.Correct!{
                        self.Movies = result.Object as? DataMovie
                        
                        let json = self.Movies
                        print(json as Any)
                        
                        DispatchQueue.main.async {
                            self.TrendingCollectionView.reloadData()
                        }
                    }
                }
            })
        }catch{
            print("Ocurrio un error")
        }
    }
    
    func LoadWhatsPopularMovies(){
        do{
            self.whatsPopular.GetAllWhatsPopularMovie(ResultCompletionHandler: {result, error in
                if let result = result {
                    if result.Correct!{
                        self.PoluarMovies = result.Object as? Popular
                        
                        let json = self.PoluarMovies
                        print(json as Any)
                        
                        DispatchQueue.main.async {
                            self.WhatsPoularCollectionView.reloadData()
                        }
                    }
                }
            })
        }catch{
            print("Ocurrio un error")
        }
    }

}


extension BaseAppViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == TrendingCollectionView{
            return Movies?.results.count ?? 0
        } else{
            return PoluarMovies?.results.count ?? 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieCollectionViewCell
        
        if collectionView == TrendingCollectionView{
            
            
            let popularMovie = self.Movies?.results[indexPath.row]
            
            cell.NameMovie.text = popularMovie?.original_title
            cell.DateMovie.text = popularMovie?.release_date

            
            DispatchQueue.main.async {

                if let url = URL(string:"https://image.tmdb.org/t/p/w600_and_h900_bestv2\(String(describing:popularMovie!.poster_path))")
                {
                    print(url)
                    DispatchQueue.global().async {
                        
                        if let data = try? Data( contentsOf:url)
                        {
                            DispatchQueue.main.async {
                                cell.ImageMovie.image = UIImage( data:data)
                            }
                        }
                    }
                    
                }
            }
            return cell
        } else {
            
            
            let popularMovie = self.PoluarMovies?.results[indexPath.row]
            
            cell.NameMovie.text = popularMovie?.original_name
            //cellB.DateMovie.text = popularMovie?.release_date

            
            DispatchQueue.main.async {

                if let url = URL(string:"https://image.tmdb.org/t/p/w600_and_h900_bestv2\(String(describing:popularMovie!.poster_path))")
                {
                    print(url)
                    DispatchQueue.global().async {
                        
                        if let data = try? Data( contentsOf:url)
                        {
                            DispatchQueue.main.async {
                                cell.ImageMovie.image = UIImage( data:data)
                                //let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:500))
                            }
                        }
                    }
                    
                }
            }
            return cell
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        // Pass the selected object to the new view controller.
    }
    
}

extension BaseAppViewController: UITabBarDelegate {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if(item.tag == 1) {
            // Code for item 1
            print("One")
            performSegue(withIdentifier: "MoreSegues", sender: self)
        }
        else if(item.tag == 2) {
            // Code for item 2
            print("two")


        } else if(item.tag == 3) {
            // Code for item 3
            print("three")
            performSegue(withIdentifier: "SettingsSegues", sender: self)
        }
    }
    
    
}
