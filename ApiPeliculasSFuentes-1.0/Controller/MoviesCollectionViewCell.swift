//
//  MoviesCollectionViewCell.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 16/11/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var PhotoMovie: UIImageView!
    @IBOutlet weak var NameMovie: UILabel!
    @IBOutlet weak var DateMovie: UILabel!
    @IBOutlet weak var CalfMovie: UILabel!
    @IBOutlet weak var DescriptionMovie: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func AddFavorites(_ sender: UIButton) {
        
        func ValidateToken(ResultCompletionHandler: @escaping (Result?, Error?) -> Void){
                        
            // prepare json data
            let json = "request_token"
            
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
            
            
            
        }
    }
    

}
