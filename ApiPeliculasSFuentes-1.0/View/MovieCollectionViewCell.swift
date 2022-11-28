//
//  MovieCollectionViewCell.swift
//  ApiPeliculasSFuentes-1.0
//
//  Created by MacBookMBA1 on 25/11/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ImageMovie: UIImageView!
    @IBOutlet weak var NameMovie: UILabel!
    @IBOutlet weak var DateMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let containerView = UIView(frame: CGRect(x:0,y:0,width:800,height:500))
//          
//
//            if let image = UIImage(named: "a_image") {
//                let ratio = image.size.width / image.size.height
//                if containerView.frame.width > containerView.frame.height {
//                    let newHeight = containerView.frame.width / ratio
//                    ImageMovie.frame.size = CGSize(width: containerView.frame.width, height: newHeight)
//                }
//                else{
//                    let newWidth = containerView.frame.height * ratio
//                    ImageMovie.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
//                }
//            }

    }

}
