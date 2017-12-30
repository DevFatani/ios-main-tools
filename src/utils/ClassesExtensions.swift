
//
//  ClassesExtensions.swift
//  Erslni
//
//  Created by Muhammad Fatani on 12/12/2017.
//  Copyright © 2017 Muhammad Fatani. All rights reserved.
//

import Foundation
import  UIKit

extension Date {
    func toString (format:String) -> String? {
        return DateFormatter(format: format).string(from: self)
    }
}
extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}



extension DateFormatter {
    
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


extension String {
    func convertToData()->Data{
        return String(self).data(using: String.Encoding.utf8, allowLossyConversion: false)!
    }
    
    func getDateDurations () -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date:Date = formatter.date(from: self)!
        return format(duration: abs(date.timeIntervalSinceNow))
    }
    
    func convertDateToUNIXFormate () -> Double{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date:Date = formatter.date(from: self)!
        return Double(date.timeIntervalSince1970)
    }
    
    
    private func format(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        return formatter.string(from: duration)!
    }
    
    func getLocalized(value:Int)-> String{
        return String.localizedStringWithFormat(NSLocalizedString("%d", comment: ""), value)
    }
}


extension Double {
    func convertToData()->Data{
        return String(self).data(using: String.Encoding.utf8, allowLossyConversion: false)!
    }
}

extension Data {
    func formatTime(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        return formatter.string(from: duration)!
    }
}
