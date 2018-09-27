//
//  MovieListPagenationModel.swift
//  MovieInfo
//
//  Created by Siva.T on 21/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit
protocol MovieListPageDelegate:class{
    func downloadedSucessMovieListFromServer(msg : String)
    func downloadedFailedMovieListFromServer(msg : String)
    
}

class MovieListPagenationModel: NSObject , APIServicesDelegate {
 
 var currentPage: NSInteger = 0
 var totalPages: NSInteger = 0
 var showLoadMore: Bool = false
 var servicesCallInpreogress: Bool = false

 var isFirstCall: Bool = false

 var arrMovieList: [MovieListItemModel] = []
 weak var delegate: MovieListPageDelegate?
 
    override init(){
        currentPage = 0
        totalPages = 0
        isFirstCall = true
        showLoadMore = true
        servicesCallInpreogress = false
    }
 
 
 func getMovieListFromServer()  {
    if self.isFirstCall == true {
        arrMovieList = []
        servicesCallInpreogress = true
        let service = ServiceClass.init(delegates: self as APIServicesDelegate)
        service.ServerConnectionForGetMoviesList(pageNumber: currentPage+1)
    }else if self.showLoadMore == true {
        apiCallForGetMoviesList()
    }else {
        sendErrorMsgToListPage(msg :"")
    }
    
    }
    

    func apiCallForGetMoviesList()  {
        if isServerRechable == true{
            servicesCallInpreogress = true
            let service = ServiceClass.init(delegates: self as APIServicesDelegate)
            service.ServerConnectionForGetMoviesList(pageNumber: currentPage+1)
        }else{
          self.sendErrorMsgToListPage(msg: AlertMessages.kNoInternetMsg)
          }
    }
    
    func sendErrorMsgToListPage(msg :String){
        servicesCallInpreogress = false
        self.delegate?.downloadedFailedMovieListFromServer(msg:msg )
    }
    
    func getMoviesListWithSucess(respDict: NSDictionary) {
     self.isFirstCall = false
        currentPage   = NSInteger(truncating: respDict["page"] as? NSNumber ?? 0)
        totalPages    = NSInteger(truncating: respDict["total_pages"] as?  NSNumber ?? 0)

        if let arrMovie = respDict["results"] as? [Any]  {
            for dict in arrMovie
            {
                guard let dictData = dict as? NSDictionary else {
                    return print("Not a dictionary")
                }
                let id            = dictData["id"] as? NSNumber ?? 0
                let imageURL           = dictData["poster_path"] as? String ?? ""
                let movideModel = MovieListItemModel.init(imgURL: imageURL, id: id)
                arrMovieList.append(movideModel)
            }
            
        }
        if currentPage == totalPages {
            self.showLoadMore = false
        }
        servicesCallInpreogress = false
        self.delegate?.downloadedSucessMovieListFromServer(msg: "")

    }
    func getMoviesListWithError(message:String) {
        sendErrorMsgToListPage(msg :message)
    }
    
 }

