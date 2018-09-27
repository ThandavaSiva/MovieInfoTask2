//
//  MovieDetailsViewControllerTests.swift
//  MovieInfoTests
//
//  Created by Siva.T on 23/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import XCTest
@testable import MovieInfo

class MovieDetailsViewControllerTests: XCTestCase, MovieDetailPageDelegate {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForDownloadMovieDetails() {
    
        let vcObj = MovieDetailsViewController()
        vcObj.viewModel = MovieDetailsViewModel.init(movieID: "8355")
        vcObj.viewModel.delegate = self
        vcObj.viewModel.getMovieDetailsFromServer()
        
    }
    func downloadedSucessMovieDetailsFromServer(msg : String){
      print("Downloaded movie detils")
    }
    func downloadedFailedMovieDetailsFromServer(msg : String){
        
    }


}
