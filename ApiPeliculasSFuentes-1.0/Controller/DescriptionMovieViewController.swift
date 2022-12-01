//
//  DescriptionMovieViewController.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 30/11/22.
//

import UIKit

class DescriptionMovieViewController: UIViewController {

    @IBOutlet weak var ImageMovie: UIImageView!
    
    var IdMovie: Int = 0
    
    var dataMovie = GetDataOfMovie()
    var Movie: DataMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(IdMovie)

        LoadDataMovie(IdMovie)
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
    func LoadDataMovie(_ IdMovie: Int){
        do{
            self.dataMovie.GetByIdDataMovie(IdMovie, ResultCompletionHandler: {result, error in
                if let result = result {
                    if result.Correct!{
                        self.Movie = result.Object as? DataMovie
                        
                        let json = self.Movie
                        //print(json as Any)
                        
                        DispatchQueue.main.async {

//                            if let url = URL(string:"https://image.tmdb.org/t/p/w1280\(String(describing:self.Movie!.results[1].poster_path))")
//                            {
//                                print(url)
//                                DispatchQueue.global().async {
//
//                                    if let data = try? Data( contentsOf:url)
//                                    {
//                                        DispatchQueue.main.async {
//                                            self.ImageMovie.image = UIImage( data:data)
//                                        }
//                                    }
//                                }
//
//                            }
                        }

                    }
                }
            })
        }catch{
            print("Ocurrio un error")
        }
    }

}
