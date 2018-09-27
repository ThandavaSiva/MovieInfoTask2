//
//  UIViewControllerHelperClass.swift
//  MovieInfo
//
//  Created by Siva.T on 21/07/18.
//  Copyright © 2018 Siva.T. All rights reserved.
//

import Foundation

extension UIViewController {

    //Get TableViewCell based from subviews
    func getCellForView(view:UIView) -> UITableViewCell?
    {
        var superView = view.superview
        while superView != nil
        {
            if superView is UITableViewCell
            {
                return superView as? UITableViewCell
            }
            else
            {
                superView = superView?.superview
            }
        }
        return nil
    }
   
    //Start Loading
    func startloading(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async {
            
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = .whiteLarge
            activityIndicator.color = UIColor.black
            activityIndicator.backgroundColor = UIColor.white.withAlphaComponent(1.0)
            activityIndicator.layer.cornerRadius = activityIndicator.frame.size.width/2
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    // stop loading
    func stopLoading(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    
    //For Convert number to Decimal String
    func df2so(_ price: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: price as NSNumber)!
    }
    
    
    
    //Load Image From URL
    func loadImageFromURLWithBlock(imageView: UIImageView , url:String,placeholderImage: UIImage?, completion: @escaping (_ status: Bool, _ imageObj: UIImage?) -> Void) {
        
        if(url.isEmpty){
            if placeholderImage != nil{
                imageView.image = placeholderImage
            }
            completion(true, placeholderImage)
            return
        }
        
        let strUU = "https://image.tmdb.org/t/p/w200/" + url
    
        let urlString = strUU.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: urlString!)!
        
        _ = imageView.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(ImageTransition.fade(1))],
                                  progressBlock:{ receivedSize, totalSize in
                                    
                                    completion(false, placeholderImage)
                                    
        },completionHandler: { image, error, cacheType, imageURL in
            
            if error != nil {
                if placeholderImage != nil{
                    imageView.image = placeholderImage
                }
                completion(true, placeholderImage)
            }else{
                completion(true, image)
                
            }
            
            
            
        })
        
    }
    // Convert mins to Hours
    func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    
    // Show UIAlertController for msg display
    func ShowAlertControllerWithMessage(strMessage : String) {
        
        if strMessage.count == 0 {
            return
        }
        
        
        let actionSheetController = UIAlertController(title: "", message: strMessage, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in

        }
        actionSheetController.addAction(cancelAction)
        // We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = self.view
        // Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // Calculate maximum lable hight for given string
    func calculateHeight(inString:String) -> CGFloat {
        let messageString = inString
        
        var fontSize = 17.0
        if UIDevice().userInterfaceIdiom == .pad {
            fontSize = 30.0
        }
        
        let attrs1 = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(fontSize))] as [NSAttributedStringKey : Any]
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attrs1)
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: self.view.frame.width-32, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        let requredSize:CGRect = rect
        return requredSize.height
    }

    
}

extension UILabel {
    // number line required to to display msg in lable
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let lines = Int(textSize.height/charSize)
        return lines

    }
}

