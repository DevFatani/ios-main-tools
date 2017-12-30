
import UIKit

class UI_CLASS: UIViewController {

    @IBOutlet weak var YOUR_STACK_VIEW: UIStackView!
 

    @IBAction func UR_ACTIONS(_ sender: UIBarButtonItem) {
      self.animateView(view: self.YOUR_STACK_VIEW, toHidden: !self.YOUR_STACK_VIEW.isHidden)
    }
    
    
    private func animateView(view: UIView, toHidden hidden: Bool) {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(), animations: {() ->  Void in
            view.isHidden = hidden
        }, completion: nil)
    }
}

