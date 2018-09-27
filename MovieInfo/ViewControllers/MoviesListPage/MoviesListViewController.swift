//
//  MoviesListViewController.swift
//  MovieInfo
//
//  Created by Siva.T on 20/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController  {
  
    @IBOutlet var collVwMoviesList: UICollectionView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var moviePageModel : MovieListPagenationModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activityIndicator)
        self.startloading(activityIndicator: activityIndicator)
        moviePageModel = MovieListPagenationModel.init()
        moviePageModel?.delegate = self as MovieListPageDelegate
        moviePageModel?.getMovieListFromServer()
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}

extension MoviesListViewController :  MovieListPageDelegate {

    func downLoadMovieListFromServer(){
        if moviePageModel?.servicesCallInpreogress == false {
            startloading(activityIndicator: activityIndicator)
        DispatchQueue.global(qos: .background).async {
       self.moviePageModel?.getMovieListFromServer()
            }
        }
    }
    
    func downloadedSucessMovieListFromServer(msg : String){
        self.stopLoading(activityIndicator: activityIndicator)
        DispatchQueue.main.async {
           self.collVwMoviesList.reloadData()
        }
    }
    func downloadedFailedMovieListFromServer(msg : String){
        self.stopLoading(activityIndicator: activityIndicator)
        DispatchQueue.main.async {
            self.collVwMoviesList.reloadData()
            self.ShowAlertControllerWithMessage(strMessage: msg)
        }
        
    }
}

extension MoviesListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    //MARK:- UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.moviePageModel == nil {
           return 0
        }else{
            return (self.moviePageModel?.arrMovieList.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListItemCollVwCell", for: indexPath) as! MovieListItemCollVwCell

        cell.backgroundColor = UIColor.white
        cell.contentView.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if moviePageModel?.arrMovieList.count != 0 {
            let cellObj: MovieListItemCollVwCell  = cell as! MovieListItemCollVwCell
            let itemModel: MovieListItemModel = (self.moviePageModel?.arrMovieList[indexPath.row])!
            if itemModel.imgURL.count != 0{
                
            self.loadImageFromURLWithBlock(imageView: cellObj.imgMovieThumb, url: itemModel.imgURL, placeholderImage: #imageLiteral(resourceName: "placeholder") , completion: { (status , imageObj) in

            })
        }

            if indexPath.row == (self.moviePageModel?.arrMovieList.count)!-1 {
            self.downLoadMovieListFromServer()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if moviePageModel?.arrMovieList.count != 0 {
            performSegue(withIdentifier: "PushToDetailsPage", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushToDetailsPage" {
            if let selectedIndexPath = self.collVwMoviesList.indexPathsForSelectedItems {
                let selected = selectedIndexPath[0]
                print("selectedRow = \(selected.row)  totalCount : \(selectedIndexPath.count)")
                let itemModel: MovieListItemModel = (self.moviePageModel?.arrMovieList[selected.row])!
                if let viewcontroller = segue.destination as? MovieDetailsViewController {
                    viewcontroller.strMovieID = "\(itemModel.id)"
                }
            }
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if moviePageModel?.arrMovieList.count != 0 {
            
            var imageCount = 0
            if UIDevice().userInterfaceIdiom == .pad {
                imageCount = 4
            }else{
                imageCount = 3
            }
            
            let totalWidth: CGFloat = collectionView.frame.size.width
            let cellSpace: CGFloat  = 5.0
            let cellOuterSpace: CGFloat  = 10.0
            let totalSpaceBnCells: CGFloat  = (cellSpace * CGFloat(imageCount - 1)) + (cellOuterSpace * 2)
            var cellWidth  = (totalWidth-totalSpaceBnCells)/CGFloat(imageCount)
            cellWidth = cellWidth - 1
            return CGSize.init(width:cellWidth , height: cellWidth)
        }else{
            return CGSize.init(width: 0, height:0)

        }
    }
  

    
    
    
}
