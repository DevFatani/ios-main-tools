

import UIKit

class UR_CLASS: UIViewController {

   
    @IBOutlet weak var svMain: UIStackView!
    
    private var copyRightStackView: UIStackView?
    

    @IBAction func YOUR_ACTION(_ sender: UIBarButtonItem) {
        
        if self.copyRightStackView == nil {
            self.copyRightStackView = self.createMyViews()
            self.copyRightStackView?.isHidden = true
            self.svMain?.addArrangedSubview(self.copyRightStackView!)
            UIView.animate(withDuration: 1.0, animations: {
                self.copyRightStackView?.isHidden = false
            })
        }else{
            UIView.animate(withDuration: 1.0, animations: {
                self.copyRightStackView?.isHidden = true
            }, completion: { (_) -> Void in
            self.copyRightStackView?.removeFromSuperview()
            self.copyRightStackView = nil
        })
    }
    
    }

    private func YOUR_CUSTOMS_VIEWS() -> UIStackView{
        
        let btnMyProfilePage = UIButton(frame: CGRect.zero)
        btnMyProfilePage.backgroundColor = .blue
        btnMyProfilePage.setTitle("SHOW PROFILE", for: .normal)
        
        let lblCopyRight = UILabel(frame: CGRect.zero)
        lblCopyRight.text = "©️ DevFatani"
        
        let stackView  = UIStackView(arrangedSubviews: [btnMyProfilePage, lblCopyRight])
        stackView.axis = . vertical
        stackView.spacing = 10.0
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }
}

