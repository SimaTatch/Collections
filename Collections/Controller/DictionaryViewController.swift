

import UIKit

class DictionaryViewController: UIViewController {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var arrayLabel: UILabel!
    @IBOutlet weak var dictionaryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let randomNumber = Int.random(in: 0...2000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dictionary \(randomNumber)"
        activityIndicator.isHidden = false
        collectionView.isHidden = false
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            createContactArray( complition: { time in
                createContactDictionary(complition: { time in
                    isWorkIndicator(isAnimated: false, indicator: activityIndicator)
                    collectionView.delegate = self
                    collectionView.dataSource = self
                })
            })
        }
    }
    
    var dictArray: [DictionaryStruct] = {
        
        var firstElementArray = DictionaryStruct()
        firstElementArray.name = "Find the first contact"
        
        var firstElementDictionary = DictionaryStruct()
        firstElementDictionary.name = "Find the first contact"
        
        var lastElementArray = DictionaryStruct()
        lastElementArray.name = "Find the last contact"
        
        var lastElementDictionary = DictionaryStruct()
        lastElementDictionary.name = "Find the last contact"
        
        var nonExistingElementArray = DictionaryStruct()
        nonExistingElementArray.name = "Search for a non-existing element"
        
        var nonExistingElementDictionary = DictionaryStruct()
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
    
//    create array functions
    func createContactArray ( complition: @escaping (Double)  -> ()) {
        let start = CFAbsoluteTimeGetCurrent()
        var contactArray = [String]()
        for i in 0 ... 10_000_000 {
            contactArray.append("Name\(String(i))")
        }
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
//    find first and last array contacts
    func findContactArray (findFirstContact: Bool, findLastContact: Bool, nonExisting: Bool, complition: @escaping (String) -> ()) {
        var firstOrLastContact = ""
        var contactArray = [String]()
        for i in 0 ... 10_000_000 {
            contactArray.append("Name\(String(i))")
        }
        if findFirstContact {
            if let currentContact = contactArray.first(where: { $0 > "0" }) {
                firstOrLastContact = currentContact
            }
        }
        if findLastContact {
            if let currentContact = contactArray.last(where: { $0 > "0" }) {
                firstOrLastContact = currentContact
            }
        }
        if nonExisting {
            if contactArray.contains("-1")  {
                firstOrLastContact = "element exists"
            } else {
                firstOrLastContact = "element doesn't exist"
            }
        }
        DispatchQueue.main.async {
            complition (String(firstOrLastContact))
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
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
    
//    find first and last dictionary contacts
    func findContactDictionary (findFirstContact: Bool, findLastContact: Bool, nonExisting: Bool, complition: @escaping (String)  -> ()) {
        var firstOrLastContact = ""
        var contactDictionary: Dictionary = [String: String]()
        for i in 0 ... 10_000_000 {
            contactDictionary [(String(i))] = "Name\(i)"
        }
        if findFirstContact {
            firstOrLastContact = contactDictionary [(String(1))]  ?? ""
        }
        if findLastContact {
            firstOrLastContact = contactDictionary [(String(10_000_000))] ?? ""
        }
        if nonExisting {
            firstOrLastContact = contactDictionary [(String(-1))]  ?? "element doesn't exist"
        }
        
        DispatchQueue.main.async {
            complition (String(firstOrLastContact))
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
        switch indexPath {
            
//            first element in array
        case [0,0]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                createContactArray() { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                    cell?.dictCellLabel.text = "First element search time: \(time) seconds \n"
                    findContactArray(findFirstContact: true,
                                          findLastContact: false,
                                           nonExisting: false,
                                          complition: { word in
                        isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                        cell?.dictCellLabel.text = (cell?.dictCellLabel.text ?? "") + "The word is: \(word)"})
                }
            }
            
//            first element in dictionary
        case [0,1]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                createContactArray() { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                    cell?.dictCellLabel.text = "First element search time: \(time) seconds \n"
                    findContactDictionary(findFirstContact: true,
                                          findLastContact: false,
                                          nonExisting: false,
                                          complition: { word in
                        isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                        cell?.dictCellLabel.text = (cell?.dictCellLabel.text ?? "") + "The word is: \(word)"})
                }
            }
            
//            last element in array
        case[0,2]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                createContactArray() { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                    cell?.dictCellLabel.text = "Last element search time: \(time) seconds \n"
                    findContactArray(findFirstContact: false,
                                          findLastContact: true,
                                          nonExisting: false,
                                          complition: { word in
                        isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                        cell?.dictCellLabel.text = (cell?.dictCellLabel.text ?? "") + "The word is: \(word)"})
                }
            }
            
//            last element in dictionary
        case[0,3]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                createContactArray() { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                    cell?.dictCellLabel.text = "Last element search time: \(time) seconds \n"
                    findContactDictionary(findFirstContact: false,
                                          findLastContact: true,
                                          nonExisting: false,
                                          complition: { word in
                        isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                        cell?.dictCellLabel.text = (cell?.dictCellLabel.text ?? "") + "The word is: \(word)"})
                }
            }
            
//            non-existing element in array
        case[0,4]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                createContactArray() { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                    cell?.dictCellLabel.text = "Last element search time: \(time) seconds \n"
                    findContactArray(findFirstContact: false,
                                     findLastContact: false,
                                     nonExisting: true,
                                     complition: { word in
                        isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                        cell?.dictCellLabel.text = (cell?.dictCellLabel.text ?? "") + "The word is: \(word)"})
                }
            }
            
//            non-existing element in dictionary
        case[0,5]:
            cell?.dictCellLabel.text = ""
            isWorkIndicator(isAnimated: true, indicator: cell!.cellActivityIndicator)
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                createContactArray() { time in
                    isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                    cell?.dictCellLabel.text = "Last element search time: \(time) seconds \n"
                    findContactDictionary(findFirstContact: false,
                                          findLastContact: false,
                                          nonExisting: true,
                                          complition: { word in
                        isWorkIndicator(isAnimated: false, indicator: cell!.cellActivityIndicator)
                        cell?.dictCellLabel.text = (cell?.dictCellLabel.text ?? "") + "The word is: \(word)"})
                }
            }
        default:
            break
        }
    }
}
