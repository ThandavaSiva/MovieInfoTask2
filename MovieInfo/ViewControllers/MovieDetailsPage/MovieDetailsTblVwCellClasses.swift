//
//  MovieDetailsTblVwCellClasses.swift
//  MovieInfo
//
//  Created by Siva.T on 21/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import Foundation

class MovieDetailsImgCell: UITableViewCell {
    @IBOutlet var imgMovieThumb: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}

class MovieDetailsHeaderCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPopularity: UILabel!
    @IBOutlet var lblDuration: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}



class MovieDetailsDiscrpCell: UITableViewCell {
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var btnShowLess: UIButton!
    
    @IBOutlet var consButtonHight: NSLayoutConstraint!
    
    @IBOutlet var imgBtnBottomLine: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class MovieDetailsCell: UITableViewCell {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDetails: UILabel!
    
    @IBOutlet var conDetailsBottom: NSLayoutConstraint!
    @IBOutlet var consDetailsTop: NSLayoutConstraint!
    
    @IBOutlet var consTitleBottom: NSLayoutConstraint!
    
    @IBOutlet var consTitleTop: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
