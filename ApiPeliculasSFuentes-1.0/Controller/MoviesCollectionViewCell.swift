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
    
    var posterTapAction: ((MoviesCollectionViewCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func AddFavorites(_ sender: UIButton) {
        posterTapAction?(self)

        
        
    }
    

}
