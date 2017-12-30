
import UIKit


class UR_CLASS: UIViewController {
 
 var objects = [Object]()

 lazy var refreshControl: UIRefreshControl = self.initUIRefreshControl()
    
    /// setup refreshControl
    func initUIRefreshControl()-> UIRefreshControl{
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "SET_YOUR_MESSAGE")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    @objc func refresh(sender:AnyObject) {
        self.refreshControl.endRefreshing()
        //MARK: UR action here
    }

}

 extension UR_CLASS : UITableViewDataSource, UITableViewDelegate{
    
    // Get number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// Action when user click on row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
   
    /// Get custom cell row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ID") as! YOUR_CELL
        cell.object = object[indexPath.row]
        return cell
    }
    
    /// Get number of elements in array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       objects.count
    }
}

class UR_CELL : UITableViewCell {
    var object :Object! { didSet{} }
}
