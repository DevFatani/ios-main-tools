//
//  Tools.swift
//
//  Created by Muhammad Fatani on 12/12/2017.
//  Copyright © 2017 Muhammad Fatani. All rights reserved.
//

import UIKit
import SwiftDate
import Foundation
import SystemConfiguration

/// Class use all common static fucntion that all of the most apps need
class Tools {
    
    static let arabic_sa =
        Region(tz: TimeZoneName.asiaRiyadh, cal: CalendarName.gregorian, loc: LocaleName.arabicSaudiArabia)
    
    
    static func getForrmatedDate(date:Date, isHours:Bool, isMinutes:Bool, isSeconds:Bool, formatType:String)->String{
        let formater  = DateFormatter()
        //        formater.dateFormat = "dd/MM/yyyy hh:mm"
        formater.dateFormat = "dd/MM\t\(isHours ? "hh\(formatType)" :"")\(isMinutes ? "mm" :"")\(isSeconds ? "\(formatType)ss":"") a"
        return formater.string(from: date)
    }
    
    /// get the root folder of the app
    ///
    /// - Returns: path of folder
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    /// validate if the mobile number is saudi number or not
    ///
    /// - Parameter mobile: user mobile
    /// - Returns: true if user mobile is saudi number other wishe false
    static func isSaudiNumber(mobile:String)->Bool{
        let mobileLength = mobile.count
        if mobileLength == 10 {
            return mobile.hasPrefix("05")
        }else if mobileLength == 9 {
            return mobile.hasPrefix("5")
        }else if mobileLength == 12 {
            return mobile.hasPrefix("9665")
        }
        return false
    }
    
    
    /// Generalize all font items in app to be the type that been chosen
    static let fontItems  = [ NSAttributedStringKey.font: UIFont(name: "Avenir-Roman", size: 17)!]
    
    /// Generalize all font items in app to be the type that been chosen
    ///
    /// - Parameter size: font size
    /// - Returns: dictionary of values that determine the font type and size
    static func setFontItemBy(size:CGFloat) -> [NSAttributedStringKey : Any] {
        return [ NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "Avenir-Roman", size: size)!]
    }
    
    /// Generalize all font on UIBarButtonItem
    ///
    /// - Parameter items: your bar button item
    static func setFontToItem(items: UIBarButtonItem...){
        for item in items {
            item.setTitleTextAttributes(self.fontItems, for: .normal)
        }
    }
    
    /// validate if the email is in correct format
    ///
    /// - Parameter email: user email to validate
    /// - Returns: true if email format is correct, otherwise false
    static func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    /// Function that show popup view to user to chose photo from CAMERA or GALLERY
    ///
    /// - Parameters:
    ///   - view: the current view that you call this function
    ///   - delegate: response after image is select
    ///   - button: this is for ipad it must send the button that has been clicked to show small popup
    /// - Returns: UIAlertController to make user show this window by call (.present(alertController, animated: true)
    static func showActionSheet(view:UIViewController, 
        delegate:UIImagePickerControllerDelegate & UINavigationControllerDelegate, _ button:UIButton?)-> UIAlertController{
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let attributedTitle = NSMutableAttributedString(string: Texts.IMPORT_IMAGE, attributes: fontItems)
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        
        alertController.addAction(UIAlertAction(title: Texts.CANCEL, style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: Texts.CAMERA, style: .default, handler: { (action) in
            importImageFrom(view: view, delegate: delegate, sourceType: .camera)
        }))
        alertController.addAction(UIAlertAction(title: Texts.GALLERY, style: .default, handler: { (action) in
            importImageFrom(view: view, delegate: delegate, sourceType: .photoLibrary)
        }))
        if let presenter = alertController.popoverPresentationController {
            presenter.sourceView = button!
            presenter.sourceRect = button!.bounds
        }
        alertController.view.tintColor =  UIColor(rgb: 0xEE6823)
        alertController.view.backgroundColor = .white
        alertController.view.layer.cornerRadius = 25
        //        view.present(alertController, animated: true)
        
        return alertController
    }
    
    
    static func showInputDiagloWith(textsFields: (UITextField) -> Swift.Void...) -> UIAlertController {
       
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.setValue(NSMutableAttributedString(string: Texts.SET_PRICE, attributes: fontItems), forKey: "attributedTitle")
        alertController.setValue(NSMutableAttributedString(string: Texts.SHOW_PRICE, attributes: fontItems), forKey: "attributedMessage")
        
        for textsField in textsFields {
            alertController.addTextField(configurationHandler: textsField)
        }
        alertController.addAction(UIAlertAction(title: Texts.CANCEL, style: .cancel, handler: nil))
        return alertController
    }
    
    /// Helper and private method thats is called by showActionSheet(:)
    ///
    /// - Parameters:
    ///   - view: the current view that you call this function
    ///   - delegate: response after image is select
    ///   - type: soruce destination camera or gallery
    fileprivate static func importImageFrom(view:UIViewController, delegate:UIImagePickerControllerDelegate & UINavigationControllerDelegate,
                                            sourceType type: UIImagePickerControllerSourceType){
        let picker = UIImagePickerController()
        picker.delegate = delegate
        picker.allowsEditing = true
        picker.sourceType = type
        view.present(picker, animated: true, completion: nil)
    }
    
    
    /// Convert arabic number foramt that input from user to english number format
    ///
    /// - Parameter arabicNumber: input from user
    /// - Returns: english number format
    static func convertNumberToEnglish(arabicNumber:String) -> Double {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale!
        let final = formatter.number(from: arabicNumber)
        let doubleNumber = Double(truncating: final!)
        return doubleNumber
    }
    
    
    ///  Function to make the TextField in error mode when the user put not correct inputs
    ///
    /// - Parameter textField: take TextField in your Ui
    static func errorUIInput(textFields:UITextField...){
        for textField in textFields {
            textField.backgroundColor = .red
            textField.textColor = .white
            textField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    
    /// Function to make the TextField in normal mode when the user
    /// put correct inputs
    /// - Parameter textField: take TextField in your Ui
    static func normalUIInput(textFields:UITextField...){
        for textField in textFields {
            textField.backgroundColor = .white
            textField.textColor = .black
            textField.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    
    /// Function that help to open url in safari
    ///
    /// - Parameter scheme: url
    static func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:]) {(success) in
                    print("Open \(scheme): \(success)")
                }
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
    
    /// method to check if the use is connect to the internet
    ///
    /// - Returns: ture if connect otherwise false
    static func Isconnect() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    static func generateFileNameByDateAndTime() -> String{
        let formater  = DateFormatter()
        let numberFormater = NumberFormatter()
        numberFormater.locale = NSLocale(localeIdentifier: "EN") as Locale!
        formater.dateFormat = "ddMMyyyyhhmmss"
        if let final = numberFormater.number(from: "\(formater.string(from: Date()))"){
            return "\(final)_\(UUID().uuidString)"
        }
        return UUID().uuidString
    }
    
    static func formatedDigits(digits:Int, value:Double) -> String{
        return String.localizedStringWithFormat(NSLocalizedString("%0.\(digits)f", comment: ""), value)
    }
    
    static func showInGoogleMapDirectionBy(lat:Double, lng:Double){
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(lat),\(lng)&zoom=14&views=traffic&q=\(lat),\(lng)")!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://");
        }
    }

     //TOOL
    private func scallingThe(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    //Get random number
    private func random(_ range:Range<Int>) -> Int{
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }

}
