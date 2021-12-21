

import UIKit

class ArrayCell: UICollectionViewCell {
    
    @IBOutlet weak var arrayLabel: UILabel!
    @IBOutlet weak var cellIndicator: UIActivityIndicatorView!
    
    
    
    var arrays: DictArrayStruct? {
        didSet {
            arrayLabel.text = arrays?.name
            cellIndicator.isHidden = true
        }
    }
}
