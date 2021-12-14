

import UIKit

class ArrayCell: UICollectionViewCell {
    
    @IBOutlet weak var arrayLabel: UILabel!
    
    var arrays: Arrays? {
        didSet {
            arrayLabel.text = arrays?.name
        }
    }
}
