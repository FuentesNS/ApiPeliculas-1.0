//
//  TestViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 24/11/22.
//

import UIKit

class BaseAppViewController: UIViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    
    var Movies: DataMovie?
    var petitonMovie = PetitionMovies()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ScrollView.canCancelContentTouches = true
        self.ScrollView.delaysContentTouches = true
        
        automaticallyAdjustsScrollViewInsets = false

        // Do any additional setup after loading the view.
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


extension BaseAppViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        let popularMovie = self.Movies?.results[indexPath.row]
        
        var idMovie = self.Movies?.results[indexPath.row].id
        
        cell.posterTapAction = { cell in
            print("Hacer metodo insertar ")
            do{
                self.petitonMovie.AddMovieFavorite(idMovie!, ResultCompletionHandler: {result, error in
                    if let result = result {
                        if result.Correct!{
                            //                            self.Movies = result.Object as? DataMovie
                            print("Pelucula agregada a favoritos")
                            //                            let json = self.Movies
                            //                            print(json as Any)
                            //
                            //                            DispatchQueue.main.async {
                            //                                self.MoviesCollectionView.reloadData()
                            //                            }
                        }
                    }
                })
            }catch{
                print("Ocurrio un error")
            }
        }
        
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
}
