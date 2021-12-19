

import UIKit

class ArrayViewController: UIViewController {
    
    @IBOutlet weak var createArrayButton: UIButton!
    @IBOutlet weak var executionTimeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    let randomNumber = Int.random(in: 0...2000)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Array \(randomNumber)"
        activityIndicator.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        
    }
    
    var oneArray: [Arrays] = {
        
        var firstArray = Arrays()
        firstArray.name = "Insert at the beginning 1000 elements one-by-one"
        
        var secondArray = Arrays()
        secondArray.name = "Insert at the beginning 1000 elements at once"
        
        var thirdArray = Arrays()
        thirdArray.name = "Insert in the middle 1000 elements one-by-one"
        
        var fourthArray = Arrays()
        fourthArray.name = "Insert in the middle 1000 elements at once"
        
        var fifthArray = Arrays()
        fifthArray.name = "Append to the end 1000 elements one-by-one"
        
        var sixthArray = Arrays()
        sixthArray.name = "Append to the end 1000 elements at once"
        
        var seventhArray = Arrays()
        seventhArray.name = "Remove at the beginning 1000 elements one-by-one"

        var eighthArray = Arrays()
        eighthArray.name = "Remove at the beginning 1000 elements at once"
        
        var ninthArray = Arrays()
        ninthArray.name = "Remove in the middle 1000 elements one-by-one"
        
        var tenthArray = Arrays()
        tenthArray.name = "Remove in the middle 1000 elements at once"
        
        var eleventhArray = Arrays()
        eleventhArray.name = "Remove at the end 1000 elements one-by-one"

        var twelfthArray = Arrays()
        twelfthArray.name = "Remove at the end 1000 elements at once"

        return [firstArray, secondArray, thirdArray, fourthArray, fifthArray, sixthArray, seventhArray, eighthArray, ninthArray, tenthArray, eleventhArray, twelfthArray]
    }()
    
    func isWorkIndicator (isAnimated: Bool, indicator: UIActivityIndicatorView) {
        if isAnimated {
            indicator.startAnimating()
            indicator.isHidden = false
        }else {
            indicator.stopAnimating()
            indicator.isHidden = true
        }
    }
    
//    create main array /insert at once/ append at once
    
    func arrayCreationAndAtOnce(insertAtOnce: Bool, at: Int, append: Bool, complition: @escaping (Double)  -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        var array10m = Array(0...9_999_999)
        let array100 = Array(0...999)
        if insertAtOnce {
            array10m.insert(contentsOf: array100, at: at)
        }
        if append {
            array10m.append(contentsOf: array100)
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
//    insert one-by-one / append one-by-one
    
    func arrayOneByOne( insertOneByOne: Bool, at: Int, append: Bool, complition: @escaping (Double) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        var array10m = Array(0...9_999_999)
        let array100 = Array(0...999)
        
        if insertOneByOne {
            for i in array100.reversed() {
                array10m.insert(i , at: at)
            }
        }
        if append {
            for i in array100.reversed() {
                array10m.append(i)
            }
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
    //    remove at once
    func arrayRemoveAtOnce(arrayToRemove: Range<Int>, complition: @escaping (Double) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        var array10m = Array(0...9_999_999)
        array10m.removeSubrange(arrayToRemove)
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    //    remove one-by-one
    func arrayRemoveOneByOne(at: Int, complition: @escaping (Double) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        var array10m = Array(0...9_999_999)
        let arrayToRemove = Array(0...999)
        for _ in arrayToRemove {
            array10m.remove(at: at)
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
    
    @IBAction func createArray(_ sender: UIButton) {
        createArrayButton.setTitle("", for: [])
        isWorkIndicator(isAnimated: true, indicator: activityIndicator)
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            arrayCreationAndAtOnce(insertAtOnce: false, at: 0, append: false) { time in
                isWorkIndicator(isAnimated: false, indicator: self.activityIndicator)
                executionTimeLabel.text = "Array creation time: \(time) seconds"
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
            
//           insert one-by-one, beginning
        case [0,0]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayOneByOne(insertOneByOne: true, at: 0, append: false){ time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
//          insert at once, beginning
        case [0,1]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayCreationAndAtOnce(insertAtOnce: true, at: 0, append: false) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
//           insert one-by-one, middle
        case [0,2]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayOneByOne(insertOneByOne:true, at: 499, append: false) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
//          insert at once, middle
        case [0,3]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayCreationAndAtOnce(insertAtOnce: true, at: 499, append: false) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
//           append one-by-one, end
        case [0,4]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayOneByOne(insertOneByOne:false, at: 0, append: true) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
//          append at once, end
        case [0,5]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayCreationAndAtOnce(insertAtOnce: false, at: 0, append: true) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
//           remove one-by-one, beginning
        case [0,6]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayRemoveOneByOne(at: 0){ time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
//          remove at once, beginning
        case [0,7]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayRemoveAtOnce(arrayToRemove: (0..<100)) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
//           remove one-by-one, middle
        case [0,8]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayRemoveOneByOne(at: 499) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
//          remove at once, middle
        case [0,9]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayRemoveAtOnce(arrayToRemove: (449..<549)) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
//           remove one-by-one, end
        case [0,10]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayRemoveOneByOne(at: 999) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
//          remove at once, end
        case [0,11]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                arrayRemoveAtOnce(arrayToRemove: (900..<999)) { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
                    cell?.arrayLabel.text = "Insertion time: \(time) seconds"
                }
            }
            
        default:
            break
        }
    }
}
