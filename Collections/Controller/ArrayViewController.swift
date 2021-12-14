

import UIKit

class ArrayViewController: UIViewController {
    
    
    @IBOutlet weak var createArrayButton: UIButton!
    @IBOutlet weak var executionTimeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let randomNumber = Int.random(in: 0...2000)

    
    var oneArray: [Arrays] = {
        var firstArray = Arrays()
        firstArray.name = "insert at the beginning 1000 elements one-by-one"
        
        var secondArray = Arrays()
        secondArray.name = "insert at the beginning 1000 elements at once"

        var thirdArray = Arrays()
        firstArray.name = "3 array"

        var fourthArray = Arrays()
        secondArray.name = "4 array"
        
        return [firstArray, secondArray, thirdArray, fourthArray]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Array \(randomNumber)"
        activityIndicator.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
    }

    func arrayCreation(insertion: Bool) -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        var array1000 = Array(0...9_999_999)
        if insertion {
            array1000.insert(contentsOf: 0...999, at: 0)
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        return Double(round(10000 * diff) / 10000)
    }
    

    
    func isWorkIndicator (isAnimated: Bool, indicator: UIActivityIndicatorView) {
        if isAnimated {
            indicator.startAnimating()
            indicator.isHidden = false
        }else {
            indicator.stopAnimating()
            indicator.isHidden = true
        }
    }
    
    @IBAction func createArray(_ sender: UIButton) {
        createArrayButton.setTitle("", for: [])
        isWorkIndicator(isAnimated: true, indicator: activityIndicator)
        DispatchQueue.main.async { [self] in
            Timer.scheduledTimer(withTimeInterval: arrayCreation(insertion: false), repeats: false) {
                (t) in
                isWorkIndicator(isAnimated: false, indicator: self.activityIndicator)
                executionTimeLabel.text = "Array creation time: \(arrayCreation(insertion: false)) seconds"
                collectionView.isHidden = false
            }
        }
    }
}

extension ArrayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ArrayCell {
            itemCell.arrays = oneArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ArrayCell
        switch indexPath {
        case [0,0]:
        cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.main.async { [self] in
                Timer.scheduledTimer(withTimeInterval: arrayCreation(insertion: true), repeats: false) {
                    (t) in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(arrayCreation(insertion: true)) seconds"
                }
            }
        default:
            break
        }
    }
}
