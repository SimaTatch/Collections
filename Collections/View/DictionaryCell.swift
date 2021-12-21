
import UIKit

class DictionaryCell: UICollectionViewCell {
    
    
    @IBOutlet weak var dictCellLabel: UILabel!
    @IBOutlet weak var cellActivityIndicator: UIActivityIndicatorView!
    
    var dicts: DictArrayStruct? {
        didSet {
            dictCellLabel.text = dicts?.name
            cellActivityIndicator.isHidden = true
        }
    }
    
}
