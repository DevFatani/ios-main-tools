

import UIKit


class UR_CLASS: UIViewController {

    func UR_ACTION () {
        self.performSegue(withIdentifier: "UR_SEGUE_ID", sender: someObjects)
    }


  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "UR_SEGUE_ID" {
            if let nxView = segue.destination as? NavigationController,
                let someObjects = sender as? String {
                nxView.someObjects = someObjects
            }
        }
    }
}