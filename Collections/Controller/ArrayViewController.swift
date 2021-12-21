

import UIKit

class ArrayViewController: UIViewController {
    
    @IBOutlet weak var createArrayButton: UIButton!
    @IBOutlet weak var executionTimeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    let randomNumber = Int.random(in: 0...2000)
    var array10m = [Int]()
    var array100 = [Int]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Array \(randomNumber)"
        activityIndicator.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        
    }
    
    var oneArray: [DictArrayStruct] = {
        
        var firstArray = DictArrayStruct()
        firstArray.name = "Insert at the beginning 1000 elements one-by-one"
        
        var secondArray = DictArrayStruct()
        secondArray.name = "Insert at the beginning 1000 elements at once"
        
        var thirdArray = DictArrayStruct()
        thirdArray.name = "Insert in the middle 1000 elements one-by-one"
        
        var fourthArray = DictArrayStruct()
        fourthArray.name = "Insert in the middle 1000 elements at once"
        
        var fifthArray = DictArrayStruct()
        fifthArray.name = "Append to the end 1000 elements one-by-one"
        
        var sixthArray = DictArrayStruct()
        sixthArray.name = "Append to the end 1000 elements at once"
        
        var seventhArray = DictArrayStruct()
        seventhArray.name = "Remove at the beginning 1000 elements one-by-one"

        var eighthArray = DictArrayStruct()
        eighthArray.name = "Remove at the beginning 1000 elements at once"
        
        var ninthArray = DictArrayStruct()
        ninthArray.name = "Remove in the middle 1000 elements one-by-one"
        
        var tenthArray = DictArrayStruct()
        tenthArray.name = "Remove in the middle 1000 elements at once"
        
        var eleventhArray = DictArrayStruct()
        eleventhArray.name = "Remove at the end 1000 elements one-by-one"

        var twelfthArray = DictArrayStruct()
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
    
//    create main array append at once
    func arrayCreationAndAtOnce( complition: @escaping (Double)  -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        let array10m = Array(0...9_999_999)
        let array100 = Array(0...999)
        let diff = CFAbsoluteTimeGetCurrent() - start
        self.array10m = array10m
        self.array100 = array100
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
//    insert at once/one-by-one
    func insertArray(atOnce: Bool, at: Int, complition: @escaping (Double) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        if atOnce {
            array10m.insert(contentsOf: array100, at: at)
        } else {
            for i in array100.reversed() {
            array10m.insert(i , at: at)
                
            }
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
//    append at once/one-by-one
    func appendArray(atOnce: Bool, complition: @escaping (Double) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        if atOnce {
            array10m.append(contentsOf: array100)
        } else {
            for i in array100.reversed() {
                array10m.append(i)
            }
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
//    remove one-by-one
    func removeOneByOneArray(at: Int, complition: @escaping (Double) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        for _ in array100 {
            array10m.remove(at: at)
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
//    remove at once
    func removeAtOnceArray(arrayToRemove: Range<Int>, complition: @escaping (Double) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        array10m.removeSubrange(arrayToRemove)
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
    @IBAction func createArray(_ sender: UIButton) {
        createArrayButton.setTitle("", for: [])
        isWorkIndicator(isAnimated: true, indicator: activityIndicator)
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            arrayCreationAndAtOnce() { time in
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
        let complition: (Double) -> () = { [weak self] time in
            cell?.arrayLabel.text = "Insertion time: \(time) seconds"
            self?.isWorkIndicator(isAnimated: false, indicator: cell!.cellIndicator)
        }
        switch indexPath {
            
//           insert one-by-one, beginning
        case [0,0]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                insertArray(atOnce: false, at: 0, complition: complition)
            }
            
//          insert at once, beginning
        case [0,1]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                insertArray(atOnce: true, at: 0, complition: complition)
            }
            
//           insert one-by-one, middle
        case [0,2]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                insertArray(atOnce: false, at: 5_000_000, complition: complition)
            }
            
//          insert at once, middle
        case [0,3]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                insertArray(atOnce: true, at: 5_000_000, complition: complition)
            }
            
//           append one-by-one, end
        case [0,4]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                appendArray(atOnce: false, complition: complition)
            }

            
//          append at once, end
        case [0,5]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                appendArray(atOnce: true, complition: complition)
            }

            
//           remove one-by-one, beginning
        case [0,6]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                removeOneByOneArray(at: 0, complition: complition)
            }
            
//          remove at once, beginning
        case [0,7]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                removeAtOnceArray(arrayToRemove: (0..<1000), complition: complition)
            }
//           remove one-by-one, middle
        case [0,8]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                removeOneByOneArray(at: 5_000_000, complition: complition)
            }

            
//          remove at once, middle
        case [0,9]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                removeAtOnceArray(arrayToRemove: (5_000_000..<5_001_000), complition: complition)
            }
//           remove one-by-one, end
        case [0,10]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                removeOneByOneArray(at: 9_999_999, complition: complition)
            }
            
//          remove at once, end
        case [0,11]:
            cell?.arrayLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellIndicator)
                DispatchQueue.global(qos: .userInitiated).async { [self] in
                    removeAtOnceArray(arrayToRemove: (9_998_999..<9_999_999), complition: complition)
                }
        default:
            break
        }
    }
}
