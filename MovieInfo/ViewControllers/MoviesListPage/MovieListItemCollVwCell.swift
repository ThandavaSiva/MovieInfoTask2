//
//  MovieListItemCollVwCell.swift
//  MovieInfo
//
//  Created by Siva.T on 20/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit

class MovieListItemCollVwCell: UICollectionViewCell {
    
    @IBOutlet var imgMovieThumb: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgMovieThumb.image = #imageLiteral(resourceName: "placeholder")

    }

    
}
