//
//  MovieDetailsDataModel.swift
//  MovieInfo
//
//  Created by Siva.T on 22/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit

class MovieDetailsDataModel: NSObject {
    
    var adult            : Bool
    var budget           : NSNumber
    var genres           : [GenresModel]
    var homepage         : String
    var movieId          : NSNumber
    var originalLanguage : String
    var originalTitle    : String
    var overview         : String
    var popularity       : NSNumber
    var posterPath       : String
    var productionCompanies   : [ProductionCompaniesModel]
    var productionCountries   : [ProductionCountriesModel]
    var spokenLanguages   : [SpokenLanguagesModel]
    var releaseDate      : String
    var revenue          : NSNumber
    var runtime          : NSNumber
    var status           : String
    var tagline          : String
    var title            : String
    var video            : Bool
    var voteAverage      : NSNumber
    var voteCount        : NSNumber
    
    
    init(adult            : Bool,
         budget           : NSNumber,
         genres           : [GenresModel],
         homepage         : String,
         movieId          : NSNumber,
         originalLanguage : String,
         originalTitle    : String,
         overview         : String,
         popularity       : NSNumber,
         posterPath       : String,
         productionCompanies   : [ProductionCompaniesModel],
         productionCountries   : [ProductionCountriesModel],
         spokenLanguages   : [SpokenLanguagesModel],
         releaseDate      : String,
         revenue          : NSNumber,
         runtime          : NSNumber,
         status           : String,
         tagline          : String,
         title            : String,
         video            : Bool,
         voteAverage      : NSNumber,
         voteCount        : NSNumber){
        
        
        self.adult                      = adult
        self.budget                     = budget
        self.genres                     = genres
        self.homepage                   = homepage
        self.movieId                    = movieId
        self.originalLanguage           = originalLanguage
        self.originalTitle              = originalTitle
        self.overview                   = overview
        self.popularity                 = popularity
        self.posterPath                 = posterPath
        self.productionCompanies        = productionCompanies
        self.productionCountries        = productionCountries
        self.spokenLanguages            = spokenLanguages
        self.releaseDate                = releaseDate
        self.revenue                    = revenue
        self.runtime                    = runtime
        self.status                     = status
        self.tagline                    = tagline
        self.title                      = title
        self.video                      = video
        self.voteAverage                = voteAverage
        self.voteCount                  = voteCount
        
    }
    
    
    
}

//GenresModel
class GenresModel: NSObject {
    var genresId              : NSNumber
    var genresName            : String
    init(genresId: NSNumber, genresName: String) {
        self.genresId = genresId
        self.genresName = genresName
    }
    
}

class ProductionCompaniesModel: NSObject {
    var companyId            : NSNumber
    var companyName          : String
    var companyLogoPath      : String
    var companyCounty        : String
    
    
    init(companyId: NSNumber, companyName: String, companyLogoPath: String, companyCounty: String) {
        self.companyId       = companyId
        self.companyName     = companyName
        self.companyLogoPath = companyLogoPath
        self.companyCounty   = companyCounty
    }
}
class ProductionCountriesModel: NSObject {
    var countryCode      : String
    var countryName      : String
    init(countryCode: String, countryName: String) {
        self.countryCode = countryCode
        self.countryName = countryName
    }
    
}

class SpokenLanguagesModel: NSObject {
    var languageCode      : String
    var language      : String
    init(languageCode: String, language: String) {
        self.languageCode = languageCode
        self.language = language
    }
    
}

