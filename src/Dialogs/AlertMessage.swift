
import UIKit

class AlertMessage {
    
    
    private var alertController:UIAlertController!
    
    static let ATTRIBUTED_TITLE = "attributedTitle"
    static let ATTRIBUTED_MESSAGE = "attributedMessage"
    static let tintColor =  UIColor(rgb: 0xFDC32E)
    
    
    /// setup and configure the font for message
    ///
    /// - Parameter message: message for user
    /// - Returns: attributed strings
    static func attributed(text:String, size:CGFloat) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text, attributes: Tools.setFontItemBy(size: size))
    }
    
    
    private init(newTitle:String) {
        self.alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        self.alertController.setValue(AlertMessage.attributed(text:newTitle, size: 20), forKey: AlertMessage.ATTRIBUTED_TITLE)
        self.alertController.view.tintColor = AlertMessage.tintColor
    }
    
    convenience init() {
        self.init(newTitle: Texts.WARNING)
        self.alertController.addAction(UIAlertAction(title:Texts.YES, style: .default, handler: nil))
    }
    
    convenience init (title:String){
        self.init(newTitle: title)
        self.alertController.addAction(UIAlertAction(title: Texts.YES, style: .default, handler: nil))
    }
    
    
    convenience init (title:String, completion:@escaping ((UIAlertAction) -> (Swift.Void))){
        self.init(newTitle: title)
        self.alertController.addAction(UIAlertAction(title:Texts.YES, style: .default, handler: completion))
    }
    
    convenience init (title:String, message:String, completion:@escaping ((UIAlertAction) -> (Swift.Void))){
        self.init(newTitle: title)
        self.alertController.setValue(AlertMessage.attributed(text:message, size: 18), forKey: AlertMessage.ATTRIBUTED_MESSAGE)
        self.alertController.addAction(UIAlertAction(title:Texts.YES, style: .default, handler: completion))
    }
    
    convenience init (title:String,
                      completionAccept:@escaping ((UIAlertAction) -> (Swift.Void)),
                      completionRefuse:@escaping ((UIAlertAction) -> (Swift.Void))){
        self.init(newTitle: title)
        self.alertController.addAction(UIAlertAction(title: Texts.YES, style: .default, handler: completionAccept))
        self.alertController.addAction(UIAlertAction(title: Texts.NO, style: .cancel, handler: completionRefuse))
    }
    
    /// call this method to set message for user
    ///
    /// - Parameter message: aler message that you want to show to user
    func message(message:String)-> AlertMessage{
        self.alertController.setValue(AlertMessage.attributed(text:message, size: 18), forKey: AlertMessage.ATTRIBUTED_MESSAGE)
        return self
    }
    
    
    /// call this method to show to user the alert message
    ///
    /// - Parameter view: to show to the current view that user in
    func show(view:UIViewController){
        view.present(self.alertController, animated: true, completion: nil)
        
    }
    
    ///  call this method to show to user the alert message and handle an action
    ///
    /// - Parameters:
    ///   - view: to show to the current view that user in
    ///   - completion: action handler after message alert shown
    func show(view:UIViewController, completion: (() -> Swift.Void)? = nil){
        view.present(self.alertController, animated: true, completion: completion)
        
    }

}
