//
//  MovieDetailsViewController.swift
//  MovieInfo
//
//  Created by Siva.T on 20/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, MovieDetailPageDelegate {

    @IBOutlet var tblVwMovieDetailObj: UITableView!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var isExpandDescription : Bool  = false
    var viewModel : MovieDetailsViewModel!
    var strMovieID :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(activityIndicator)
        self.startloading(activityIndicator: activityIndicator)
        self.viewModel = MovieDetailsViewModel.init(movieID: strMovieID)
        self.viewModel.delegate = self
        self.viewModel.getMovieDetailsFromServer()
    
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- UIButton Action Methods
    @objc func btnShowFullOrLess(sender: Any)  {
        isExpandDescription = !isExpandDescription
        UIView.performWithoutAnimation {
            self.tblVwMovieDetailObj.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
        }
    }
    func downloadedSucessMovieDetailsFromServer(msg : String){
        self.stopLoading(activityIndicator: activityIndicator)
        DispatchQueue.main.async { // Correct
        self.tblVwMovieDetailObj.reloadData()
        }
    }
    func downloadedFailedMovieDetailsFromServer(msg : String){
        self.stopLoading(activityIndicator: activityIndicator)
        DispatchQueue.main.async { // Correct
        self.tblVwMovieDetailObj.reloadData()
        self.ShowAlertControllerWithMessage(strMessage: msg)

        }

    }
}

extension MovieDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel == nil || viewModel.dataViewModel == nil  {
            return 0
        }else{
            return 2
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return 12
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            let totalWidth: CGFloat = tableView.frame.size.width
            let imageHight: CGFloat = totalWidth/2.3
            return  imageHight + 16
        }else{
            if indexPath.row == 0 || indexPath.row == 11 {
                return UITableViewAutomaticDimension
            }
            
            let moviewDetails = self.getMoviewDetailsText(indexPath: indexPath)
            if moviewDetails.1.count == 0 {
             return 0
            }
            return UITableViewAutomaticDimension
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsImgCell", for: indexPath) as! MovieDetailsImgCell
            
            self.loadImageFromURLWithBlock(imageView: cell.imgMovieThumb, url: (viewModel.dataViewModel?.posterPath)!, placeholderImage: nil) { (complete, image) in
                cell.imgMovieThumb.contentMode = .scaleAspectFit
            }
            return cell
        }else{
            
            if indexPath.row == 0 || indexPath.row == 11 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsDiscrpCell", for: indexPath) as! MovieDetailsDiscrpCell
                
                cell.btnShowLess.backgroundColor = UIColor.white
                cell.btnShowLess.tintColor = UIColor.blue

                if indexPath.row == 11 {
                    cell.lblDescription.text = ""
                    cell.consButtonHight.constant = 0
                    cell.imgBtnBottomLine.isHidden = false
                    cell.btnShowLess.isHidden = true
                    cell.lblDescription.isHidden = true
                }else {
                
                if viewModel.dataViewModel?.overview.count != 0 {
                    cell.lblDescription.numberOfLines = 0
                    cell.lblDescription.text = viewModel.dataViewModel?.overview
                    
                    
                    cell.imgBtnBottomLine.isHidden = false
                    cell.lblDescription.isHidden = false

                    if cell.lblDescription.numberOfVisibleLines < 5 {
                        cell.consButtonHight.constant = 10
                        cell.btnShowLess.isHidden = true
                    }else{
                        cell.consButtonHight.constant = 24
                        cell.btnShowLess.isHidden = false
                        cell.btnShowLess.addTarget(self, action: #selector(btnShowFullOrLess(sender:)), for: .touchUpInside)
                        if isExpandDescription == true{
                            cell.btnShowLess.setTitle("Show Less...", for: .normal)
                            cell.lblDescription.numberOfLines = 0
                        }else{
                            cell.btnShowLess.setTitle("Show Full...", for: .normal)
                            cell.lblDescription.numberOfLines = 4
                        }

                    }
                }else{
                    cell.lblDescription.text = ""
                    cell.consButtonHight.constant = 0
                    cell.imgBtnBottomLine.isHidden = true
                    cell.btnShowLess.isHidden = true
                    cell.lblDescription.isHidden = true
                }
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsCell", for: indexPath) as! MovieDetailsCell
                
                let moviewDetails = self.getMoviewDetailsText(indexPath: indexPath)
                
                
                if moviewDetails.1.count != 0 {
                    cell.lblTitle.isHidden = false
                    cell.lblTitle.isHidden = false
                    
                    cell.consTitleTop.constant = 8
                    cell.consDetailsTop.constant = 8

                    cell.consTitleBottom.constant = 4
                    cell.conDetailsBottom.constant = 4
                    
                    cell.lblTitle.numberOfLines = 0
                    cell.lblDetails.numberOfLines = 0

                    cell.lblTitle.text = moviewDetails.0
                    cell.lblDetails.text = moviewDetails.1
            
                }else{
                    cell.lblTitle.text = ""
                    cell.lblDetails.text = ""
                    cell.consTitleTop.constant = 0
                    cell.consTitleBottom.constant = 0
                    cell.consDetailsTop.constant = 0
                    cell.conDetailsBottom.constant = 0
                    cell.lblTitle.isHidden = true
                    cell.lblTitle.isHidden = true
                }
                
                return cell
            }
            
            
           
        }
    }
    
    func getMoviewDetailsText(indexPath: IndexPath) ->(String , String) {
        
        var titleText = ""
        var valueText = ""
        if indexPath.row == 1 {
            titleText = "Original Title"
            valueText = (viewModel.dataViewModel?.originalTitle)!
        }else if indexPath.row == 2 {
            titleText = "Tagline"
            valueText = (viewModel.dataViewModel?.tagline)!
        }else if indexPath.row == 3 {
            titleText = "Status"
            valueText = (viewModel.dataViewModel?.status)!
        }else if indexPath.row == 4 {
            titleText = "Release Date"
            valueText = (viewModel.dataViewModel?.releaseDate)!
        }else if indexPath.row == 5 {
            titleText = "Languages"
            let idArray = viewModel.dataViewModel?.spokenLanguages.map({ (model: SpokenLanguagesModel) -> String in
                model.language
            })
            if idArray?.count != 0 {
                if idArray?.count == 1 {
                    titleText = "Language"
                }
                valueText = (idArray?.joined(separator: ","))!
            }
        }
        else if indexPath.row == 6 {
            titleText = "Generes"
            
            let idArray = viewModel.dataViewModel?.genresArry.map({ (model: GenresModel) -> String in
                model.genresName
            })
            if idArray?.count != 0 {
                if idArray?.count == 1 {
                    titleText = "Genere"
                }

                valueText = (idArray?.joined(separator: ","))!
            }
        }else if indexPath.row == 7 {
            titleText = "Budget"
            valueText =  df2so(Double(truncating: (viewModel.dataViewModel?.budget)!))
            valueText = valueText == "0" ? "" : "$"+valueText
        }else if indexPath.row == 8 {
            titleText = "Revenue"
            valueText = df2so(Double(truncating: (viewModel.dataViewModel?.revenue)!))
            valueText = valueText == "0" ? "" : "$"+valueText
        }else if indexPath.row == 9 {
            titleText = "Production Companies"
            let idArray = viewModel.dataViewModel?.productionCompanies.map({ (model: ProductionCompaniesModel) -> String in
                model.companyName
            })
            if idArray?.count != 0 {
                if idArray?.count == 1 {
                    titleText = "Production Company"
                }
                
                valueText = (idArray?.joined(separator: ","))!
            }
            
        }else if indexPath.row == 10 {
            titleText = "Production Countries"
            let idArray = viewModel.dataViewModel?.productionCountries.map({ (model: ProductionCountriesModel) -> String in
                model.countryName
            })
            if idArray?.count != 0 {
                if idArray?.count == 1 {
                    titleText = "Production Country"
                }
                valueText = (idArray?.joined(separator: ","))!
            }
        }
        
        return (titleText, valueText)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        
        var hight = calculateHeight(inString: (viewModel?.dataViewModel?.title)!)
        hight = hight + 50
        
        if UIDevice().userInterfaceIdiom == .pad {
            hight = hight + 80
        }
        
        return hight <= 86 ? 86 : hight
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsHeaderCell") as! MovieDetailsHeaderCell
        
        header.lblTitle.text = viewModel?.dataViewModel?.title

        let x = viewModel?.dataViewModel?.popularity ?? 0
        let popularity = Double(round(1000 * Double(truncating: x))/1000)
        header.lblPopularity.text = "Popularity : \(popularity)"
    
        let runTimeDuration = minutesToHoursMinutes(minutes: viewModel?.dataViewModel?.runtime as! Int)
        if runTimeDuration.hours != 0 {
            header.lblDuration.text = "Duration : \(runTimeDuration.hours)Hrs:\(runTimeDuration.leftMinutes)Mins"
        }else{
            header.lblDuration.text = "Duration : \(runTimeDuration.leftMinutes)Mins"

        }
        
       

        if UIDevice().userInterfaceIdiom == .pad {
            header.lblTitle.font = UIFont.boldSystemFont(ofSize: 30)
            header.lblDuration.font = UIFont.systemFont(ofSize: 24)
            header.lblPopularity.font = UIFont.systemFont(ofSize: 24)
            
        }else{
            header.lblTitle.font = UIFont.boldSystemFont(ofSize: 17)
            header.lblDuration.font = UIFont.systemFont(ofSize: 13)
            header.lblPopularity.font = UIFont.systemFont(ofSize: 13)

        }
        

        
        
        
        header.contentView.backgroundColor = UIColor.white
        return header.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return  view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && viewModel.dataViewModel?.homepage.count != 0 {
            if let url = URL(string: (viewModel.dataViewModel?.homepage)!) {
                UIApplication.shared.open(url, options: [:])
            }
            
        }
        
    }
   
    
    
    
    
}
