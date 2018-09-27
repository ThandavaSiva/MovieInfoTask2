//
//  MovieDetailsViewModel.swift
//  MovieInfo
//
//  Created by Siva.T on 21/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit
protocol MovieDetailPageDelegate:class{
    func downloadedSucessMovieDetailsFromServer(msg : String)
    func downloadedFailedMovieDetailsFromServer(msg : String)
    
}
class MovieDetailsViewModel: NSObject, APIServicesDelegate {

    var movieID: String = "0"
    var dataViewModel: MovieDetailsDataViewModel?
    weak var delegate: MovieDetailPageDelegate?
    
    init(movieID: String){
        self.movieID = movieID
        dataViewModel = nil
            
            //MovieDetailsDataViewModel.init(dataModel: MovieDetailsDataModel.init(adult: false, budget: 0, genres: [], homepage: "", movieId: 0, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "", productionCompanies: [], productionCountries: [], spokenLanguages: [], releaseDate: "", revenue: 0, runtime: 0, status: "", tagline: "", title: "", video: false, voteAverage: 0, voteCount: 0))

    
    }
   
  
    func getMovieDetailsFromServer()  {
        if isServerRechable == true {
            let service = ServiceClass.init(delegates: self as APIServicesDelegate)
            service.ServerConnectionForGetMovieDetails(movieID: self.movieID)
        }else{
            DispatchQueue.main.async {
                self.delegate?.downloadedFailedMovieDetailsFromServer(msg: AlertMessages.kNoInternetMsg)
                return
            }
        }
    }
    
    
    func getMoviesDetailsWithSucess(respDict: NSDictionary){
        
        var arrGenresModel:[GenresModel] = []
        if let arrGenres = respDict["genres"] as? [Any]  {
            for dict in arrGenres
            {
                guard let dictData = dict as? NSDictionary else {
                    return print("Not a dictionary")
                }
                
                let name            = dictData["name"] as? String ?? ""
                let id           = dictData["id"] as? NSNumber ?? 0
                let genresModel = GenresModel.init(genresId: id, genresName: name)
                arrGenresModel.append(genresModel)
            }
        }
        
        var arrProdCompaniesModel:[ProductionCompaniesModel] = []
        if let arrProdCompanies = respDict["production_companies"] as? [Any]  {
            for dict in arrProdCompanies
            {
                guard let dictData = dict as? NSDictionary else {
                    return print("Not a dictionary")
                }
                
                let name            = dictData["name"] as? String ?? ""
                let id           = dictData["id"] as? NSNumber ?? 0
                let originCountry            = dictData["origin_country"] as? String ?? ""
                let logoPath            = dictData["logo_path"] as? String ?? ""

                let prodComyModel = ProductionCompaniesModel.init(companyId: id, companyName: name, companyLogoPath: logoPath, companyCounty: originCountry)
                arrProdCompaniesModel.append(prodComyModel)
            }

            
        }

        var arrProdCountriesModel:[ProductionCountriesModel] = []

        if let arrProdCountries = respDict["production_countries"] as? [Any]  {
            
            for dict in arrProdCountries
            {
                guard let dictData = dict as? NSDictionary else {
                    return print("Not a dictionary")
                }
                let name            = dictData["name"] as? String ?? ""
                let counCode           = dictData["iso_3166_1"] as? String ?? ""
                let prodCountyModel = ProductionCountriesModel.init(countryCode: counCode, countryName: name)
                arrProdCountriesModel.append(prodCountyModel)
            }
            
            
        }
        
        
        var arrSpokenLanguagesModel:[SpokenLanguagesModel] = []

        if let arrSpokenLanguages = respDict["spoken_languages"] as? [Any]  {
            for dict in arrSpokenLanguages
            {
                guard let dictData = dict as? NSDictionary else {
                    return print("Not a dictionary")
                }
                let name            = dictData["name"] as? String ?? ""
                let counCode           = dictData["iso_639_1"] as? String ?? ""
                let prodCountyModel = SpokenLanguagesModel.init(languageCode: counCode, language: name)
                arrSpokenLanguagesModel.append(prodCountyModel)
            }
            
            
        }

        
        let adult = respDict ["adult"] as? Bool ?? false
        let budget = respDict ["budget"] as? NSNumber ?? 0
        let homepage = respDict ["homepage"] as? String ?? ""
        let id = respDict ["id"] as? NSNumber ?? 0
        let originalLanguage = respDict ["original_language"] as? String ?? ""
        let originalTitle = respDict ["original_title"] as? String ?? ""
        let overview = respDict ["overview"] as? String ?? ""
        let poster_path = respDict ["poster_path"] as? String ?? ""
        let popularity = respDict ["popularity"] as? NSNumber ?? 0
        let releaseDate = respDict ["release_date"] as? String ?? ""
        let revenue = respDict ["revenue"] as? NSNumber ?? 0
        let runtime = respDict ["runtime"] as? NSNumber ?? 0
        let status = respDict ["status"] as? String ?? ""
        let tagline = respDict ["tagline"] as? String ?? ""
        let title = respDict ["title"] as? String ?? ""
        let video = respDict ["video"] as? Bool ?? false
        let voteAverage = respDict ["vote_average"] as? NSNumber ?? 0
        let voteCount = respDict ["vote_count"] as? NSNumber ?? 0

        dataViewModel = MovieDetailsDataViewModel.init(dataModel: MovieDetailsDataModel.init(adult: adult, budget: budget, genres: arrGenresModel, homepage: homepage, movieId: id, originalLanguage: originalLanguage, originalTitle: originalTitle, overview: overview, popularity: popularity, posterPath: poster_path, productionCompanies: arrProdCompaniesModel, productionCountries: arrProdCountriesModel, spokenLanguages: arrSpokenLanguagesModel, releaseDate: releaseDate, revenue: revenue, runtime: runtime, status: status, tagline: tagline, title: title, video: video, voteAverage: voteAverage, voteCount: voteCount))


        self.delegate?.downloadedSucessMovieDetailsFromServer(msg: "")
    }
    func getMoviesDetailsWithError(message:String){
        self.delegate?.downloadedFailedMovieDetailsFromServer(msg: message)
    }

}
