

import UIKit


class UR_CLASS: UIViewController { 

    var objects = [Object]()
    
}

extension UI_CLASS:: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YOUR_CELL_ID", for: indexPath) as! YOUR_CUSTOM_CELL
        cell.object = self.objects[indexPath.row]
        return cell
    }
}