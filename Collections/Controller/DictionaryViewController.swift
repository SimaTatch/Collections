

import UIKit

class DictionaryViewController: UIViewController {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var arrayLabel: UILabel!
    @IBOutlet weak var dictionaryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let randomNumber = Int.random(in: 0...2000)
    var contactArray = [String]()
    var contactDictionary = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dictionary \(randomNumber)"
        activityIndicator.isHidden = false
        collectionView.isHidden = false
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            createContactArray( complition: { time in
                DispatchQueue.global(qos: .userInitiated).async {
                    createContactDictionary(complition: { time in
                        isWorkIndicator(isAnimated: false, indicator: activityIndicator)
                        collectionView.delegate = self
                        collectionView.dataSource = self
                    })
                }
            })
        }
    }
    
    var dictArray: [DictArrayStruct] = {
        
        var firstElementArray = DictArrayStruct()
        firstElementArray.name = "Find the first contact"
        
        var firstElementDictionary = DictArrayStruct()
        firstElementDictionary.name = "Find the first contact"
        
        var lastElementArray = DictArrayStruct()
        lastElementArray.name = "Find the last contact"
        
        var lastElementDictionary = DictArrayStruct()
        lastElementDictionary.name = "Find the last contact"
        
        var nonExistingElementArray = DictArrayStruct()
        nonExistingElementArray.name = "Search for a non-existing element"
        
        var nonExistingElementDictionary = DictArrayStruct()
        nonExistingElementDictionary.name = "Search for a non-existing element"
        
        return [firstElementArray, firstElementDictionary, lastElementArray, lastElementDictionary, nonExistingElementArray, nonExistingElementDictionary]
        
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
    
//    create array function
    func createContactArray ( complition: @escaping (Double)  -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        var contactArray = [String]()
        for i in 0 ... 10_000_000 {
            contactArray.append("Name\(String(i))")
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        self.contactArray = contactArray
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
  
//    create dictionary function
    func createContactDictionary (complition: @escaping (Double)  -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        var contactDictionary: Dictionary = [String: String]()
        for i in 0 ... 10_000_000 {
            contactDictionary [String(i)] = "Name\(i)"
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        self.contactDictionary = contactDictionary
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
    func findAtArray(element: String, complition: @escaping (Double, String) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        let result = contactArray.first(where: { $0 == element }) ?? "element doesn't exist"
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000), result)
        }
    }
    func findAtDictionary(element: String, complition: @escaping (Double, String) -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        let result = contactDictionary[element] ?? "element doesn't exist"
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000), result)
        }
    }

}

extension DictionaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dictArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dictionaryCell", for: indexPath) as? DictionaryCell {
            itemCell.dicts = dictArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? DictionaryCell
        let complition: (Double, String) -> () = { [weak self] time, word in
            cell?.dictCellLabel.text = "Element search time: \(time) seconds \n"
            cell?.dictCellLabel.text = ((cell?.dictCellLabel.text ?? "") + "The word is: \(word)")
            self?.isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
        }
        switch indexPath {
            
//            first element in array
        case [0,0]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                findAtArray(element: contactArray.first ?? "", complition: complition)
            }
            
//            first element in dictionary
        case [0,1]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                findAtDictionary(element: contactDictionary.keys.first ?? "", complition: complition)
            }
            
//            last element in array
        case[0,2]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                findAtArray(element: contactArray.last ?? "", complition: complition)
            }
            
//            last element in dictionary
        case[0,3]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                findAtDictionary(element: contactDictionary.keys.first ?? "", complition: complition)

            }
            
//            non-existing element in array
        case[0,4]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                findAtArray(element: "", complition: complition)
            }
            
//            non-existing element in dictionary
        case[0,5]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                findAtDictionary(element: "", complition: complition)
            }
        default:
            break
        }
    }
}
