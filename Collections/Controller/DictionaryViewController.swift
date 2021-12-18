

import UIKit

class DictionaryViewController: UIViewController {

    let randomNumber = Int.random(in: 0...2000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dictionary \(randomNumber)"
    }
    
    func createContactArray () -> Array<String> {
        var contactArray = [String]()
        for i in 0 ... 100 {
            contactArray.append("Name\(String(i))")
        }
        return contactArray
    }

    
//
//    func createContactDictionary () -> Dictionary<String, String>{
//        var contactDictionary: Dictionary = [String: String]()
//        for i in 0 ... 10_000_000 {
//            contactDictionary [String(i)] = "Name"
//        }
//       return contactDictionary
//    }
//
//
//    let dict = createContactDictionary()
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
