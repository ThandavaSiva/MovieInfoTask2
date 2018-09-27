//
//  MovieDetailsDataViewModel.swift
//  MovieInfo
//
//  Created by Siva.T on 22/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit

class MovieDetailsDataViewModel: NSObject {
    var aDataModel: MovieDetailsDataModel
    init(dataModel : MovieDetailsDataModel) {
        self.aDataModel = dataModel
    }
    
    var adult : Bool{
        return self.aDataModel.adult
    }
    var budget : NSNumber{
        return self.aDataModel.budget
    }
    var genresArry : [GenresModel]{
        return self.aDataModel.genres
    }
    var homepage : String{
        return self.aDataModel.homepage
    }
    var movieId : NSNumber{
        return self.aDataModel.movieId
    }
    var originalLanguage : String{
        return self.aDataModel.originalLanguage
    }
    var originalTitle : String{
        return self.aDataModel.originalTitle
    }
    var overview : String{
        return self.aDataModel.overview
    }
    var popularity : NSNumber{
        return self.aDataModel.popularity
    }
    var posterPath : String{
        return self.aDataModel.posterPath
    }
    var productionCompanies : [ProductionCompaniesModel]{
        return self.aDataModel.productionCompanies
    }
    
    var productionCountries : [ProductionCountriesModel]{
        return self.aDataModel.productionCountries
    }
    var spokenLanguages : [SpokenLanguagesModel]{
        return self.aDataModel.spokenLanguages
    }
    
    var releaseDate : String{
        return self.aDataModel.releaseDate
    }
    var status : String{
        return self.aDataModel.status
    }
    var tagline : String{
        return self.aDataModel.tagline
    }
    var title : String{
        return self.aDataModel.title
    }
    var revenue : NSNumber{
        return self.aDataModel.revenue
    }
    
    var runtime : NSNumber{
        return self.aDataModel.runtime
    }
    
    var voteAverage : NSNumber{
        return self.aDataModel.voteAverage
    }
    var voteCount : NSNumber{
        return self.aDataModel.voteCount
    }
    var video : Bool{
        return self.aDataModel.video
    }
    
}



