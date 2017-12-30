

import UIKit

class BaseViewController: UIViewController, MainResponse, SocketConnection {

    let TAG = "BaseViewController"
    
    /// show alert message, need in every view to alert the user about an action
    lazy var alert:AlertMessage = self.initAlertMessage()
    
    /// this function needed to setup the alert because the object is lazy
    ///
    /// - Returns: AlertMessage
    func initAlertMessage() -> AlertMessage{
        return AlertMessage()
    }
    
    /// show indicator on requests to alert the user that an action happend
    lazy var indicator: UIActivityIndicatorView = self.setupIndicator()
    
    /// this function needed to setup the indicator because the object is lazy
    ///
    /// - Returns: UIActivityIndicatorView
    func setupIndicator() -> UIActivityIndicatorView{
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.center = self.view.center
        indicator.color = .blue
        return indicator
    }
    
    
    /// Call this function when there is request is about to start
    func startLoding(){
        self.view.isUserInteractionEnabled = false
        self.indicator.startAnimating()
        self.view.addSubview(self.indicator)
    }
    
    /// Call this function when the request is finish
    func finishLoading(){
        self.view.isUserInteractionEnabled = true
        self.indicator.stopAnimating()
        self.view.willRemoveSubview(self.indicator)
    }
    
    /// navigate to the views that the user chosen from the slide menu
    ///
    /// - Parameter hostController: the current view to match the current view with the destination view
    func showSlideMenu(_ id:String){
        self.performSegue(withIdentifier: "Show Slide Menu", sender: id)
    }
    
    /// Call this method to show alert message
    ///
    /// - Parameter message: text that user must interact with it
    func showAlartWith(message:String){
        self.alert.message(message: message).show(view: self)
    }
    
    func onSuccess(message: String) {
        self.finishLoading()
        Logger.normal(tag: self.TAG, message: message)
    }
    
    
    func onFail(message: String) {
        self.finishLoading()
        Logger.error(tag: self.TAG, message: message)
        
        if message.lowercased() == "fail, please try again" {return}
        self.showAlartWith(message: message)
    }
    
    /// System call this method when keybord is shown, When the user click on empty space the keyboard must go
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func onUnknownHost(message: String) {
        Logger.error(tag: TAG, message: message)
        self.alert.message(message: Texts.ERROR_CONNECTION).show(view: self)
        self.finishLoading()
    }
    
    func onTimeoutOccur(message: String) {
        self.finishLoading()
        Logger.error(tag: self.TAG, message: message)
        self.alert.message(message: Texts.ERROR_CONNECTION).show(view: self)
        
    }
}

