//
//  MovieListItemModel.swift
//  MovieInfo
//
//  Created by Siva.T on 20/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit

class MovieListItemModel: NSObject {
    
    var imgURL  : String
    var id  : NSNumber

    init(imgURL: String,id  : NSNumber ) {
        self.imgURL = imgURL
        self.id = id
    }
    
}
