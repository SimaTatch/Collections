

import UIKit

class DictionaryViewController: UIViewController {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    let randomNumber = Int.random(in: 0...2000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dictionary \(randomNumber)"
        activityIndicator.isHidden = false
        
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
    
    func createContactArray (complition: @escaping (Double)  -> ()) -> Array<String> {
        let start = CFAbsoluteTimeGetCurrent()
        var contactArray = [String]()
        for i in 0 ... 100 {
            contactArray.append("Name\(String(i))")
        }
        return contactArray
        let diff = CFAbsoluteTimeGetCurrent() - start
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }

    func createContactDictionary (complition: @escaping (Double)  -> ()) -> Dictionary<String,String> {
        let start = CFAbsoluteTimeGetCurrent()
        var contactDictionary: Dictionary = [String: String]()
        for i in 0 ... 10_000_000 {
            contactDictionary [String(i)] = "Name\(i)"
        }
        return contactDictionary
        let diff = CFAbsoluteTimeGetCurrent() - start
        return contactDictionary
        DispatchQueue.main.async {
            complition (Double(round(10000 * diff) / 10000))
        }
    }
// теперь будет просто словарь ["Name1": "1"] идущий не по порядку

    
    
    
//    здесь extension и loop, они помогают свапнуть местами ключи и значения, а потом отсортировать по порядку
//    в плейграунде это сработало, тут уже вылезают ошибки, я не понимаю как их пофиксить.


//    let dict = createContactDictionary(DictionaryViewController)
//    if let swappedDict = Dictionary(swappingKeysAndValues: dict) {
//        print(swappedDict)
//    }else {
//        print("Unable to swap keys and values")
//    }
//
//    for (k,v) in (Array(dict).sorted {$0.1 < $1.1}) {
//        print("\(k):\(v)")
//    }
//
//}
//
//extension Dictionary where Value: Hashable {
//    struct DuplicateValuesError: Error { }
//    init?(swappingKeysAndValues dict: [Value:  Key]) {
//        do {
//            try self.init(dict.lazy.map { ($0.value, $0.key) },
//                          uniquingKeysWith: { _,_ in throw DuplicateValuesError() })
//        } catch {
//            return nil
//        }
//    }
//}



}
