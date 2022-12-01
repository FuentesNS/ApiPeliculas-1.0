//
//  MoreViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 29/11/22.
//

import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
    var IdMovie: Int = 0
    
    var Movies: DataMovie?
    var typePetition = PetitionMovies()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        
        MovieCollectionView.delegate = self
        MovieCollectionView.dataSource = self
        self.MovieCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
        //        self.tabBar.barStyle = .blackOpaque
        //        self.tabBar.layer.cornerRadius = 20
        //        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // Do any additional setup after loading the view.
        LoadTypePetionMovie("popular")
        
    }
    
    @IBAction func SegmentOption(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            LoadTypePetionMovie("popular")
        } else if sender.selectedSegmentIndex == 1 {
            LoadTypePetionMovie("now_playing")
        } else if sender.selectedSegmentIndex == 2 {
            LoadTypePetionMovie("upcoming")
        } else {
            LoadTypePetionMovie("top_rated")
        }
    }
    
    @IBAction func ReturnView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func LoadTypePetionMovie(_ Petition: String){
        do{
            self.typePetition.GetTypePetitionMovie(Petition, ResultCompletionHandler: {result, error in
                if let result = result {
                    if result.Correct!{
                        self.Movies = result.Object as? DataMovie
                        
                        let json = self.Movies
                        print(json as Any)
                        
                        DispatchQueue.main.async {
                            self.MovieCollectionView.reloadData()
                        }
                    }
                }
            })
        }catch{
            print("Ocurrio un error")
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MoreViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Movies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieCollectionViewCell
        
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
    }
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        self.IdMovie = (self.Movies?.results[indexPath.row].id)!
        
        
        self.performSegue(withIdentifier: "DescriptionMovie", sender: self)
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DescriptionMovie"{
            
            let descriptionMovieViewController = segue.destination as?  DescriptionMovieViewController
            descriptionMovieViewController?.IdMovie = self.IdMovie
        }
    }
}
