//
//  ServiceClass.swift
//  MovieInfo
//
//  Created by Siva.T on 21/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit

class ServiceClass: NSObject {
    struct URLs_Struct {
        
        static let kGetMovieList             =    "/3/movie/popular?api_key=7a312711d0d45c9da658b9206f3851dd&page="
        static let kGetMovieDetails1                   =    "/3/movie/"
        static let kGetMovieDetails2                   =    "?api_key=7a312711d0d45c9da658b9206f3851dd"

        
    }
   //  https://api.themoviedb.org/3/movie/movie_id?api_key=7a312711d0d45c9da658b9206f3851dd
    open weak var delegate: APIServicesDelegate?
    
    public init(delegates: APIServicesDelegate) {
        self.delegate = delegates
    }

    func ServerConnectionForGetMoviesList(pageNumber: NSInteger) {
        let configURL:String = Bundle.main.object(forInfoDictionaryKey: "APIServiceBaseUrl") as! String
        guard let url = URL(string: configURL  + URLs_Struct.kGetMovieList + "\(pageNumber)" ) else {
            return
        }
        
        print("\(url.absoluteString)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: [:], options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                let errorMsg: String = (error?.localizedDescription)!
                self.delegate?.getMoviesListWithError!(message: errorMsg)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
                if(error != nil){
                    let errorMsg: String = (error?.localizedDescription)!
                    self.delegate?.getMoviesListWithError!(message: errorMsg)
                }else{
                    self.delegate?.getMoviesListWithError!(message: "")
                }
                return
            }
            
            let appSettingDict = try! JSONSerialization.jsonObject(with: data, options: [] ) as! NSDictionary
            //print ("\(appSettingDict)")
            self.delegate?.getMoviesListWithSucess!(respDict: appSettingDict)
        }
        task.resume()
        
    }
    
    func ServerConnectionForGetMovieDetails(movieID: String) {
        let configURL:String = Bundle.main.object(forInfoDictionaryKey: "APIServiceBaseUrl") as! String
        //let urlSrt = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=7a312711d0d45c9da658b9206f3851dd"
        guard let url = URL(string: configURL + URLs_Struct.kGetMovieDetails1 + "\(movieID)" +   URLs_Struct.kGetMovieDetails2   ) else {
            return
        }
        
        let request = NSMutableURLRequest(url: url ,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 60.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
               // print(error)
                let errorMsg: String = (error?.localizedDescription)!
                self.delegate?.getMoviesDetailsWithError!(message: errorMsg)
            } else {
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    if(error != nil){
                        let errorMsg: String = (error?.localizedDescription)!
                        self.delegate?.getMoviesDetailsWithError!(message: errorMsg)
                    }else{
                        self.delegate?.getMoviesDetailsWithError!(message: AlertMessages.kInternalError)
                    }
                    return
                }else{
                    
                    let appSettingDict = try! JSONSerialization.jsonObject(with: data!, options: [] ) as! NSDictionary
                   // print ("\(appSettingDict)")
                    self.delegate?.getMoviesDetailsWithSucess!(respDict: appSettingDict)
                
                }
            }
        })
        
        dataTask.resume()

        }
        
    
}
@objc protocol APIServicesDelegate: class {
    
    @objc optional func getMoviesListWithSucess(respDict: NSDictionary)
    @objc optional func getMoviesListWithError(message:String)
    
    @objc optional func getMoviesDetailsWithSucess(respDict: NSDictionary)
    @objc optional func getMoviesDetailsWithError(message:String)

    
}
