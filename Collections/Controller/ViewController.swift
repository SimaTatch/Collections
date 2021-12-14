

import UIKit

class CollectionsTypes {
    var collectionName: String?
    init (collectionName: String) {
        self.collectionName = collectionName
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var collectionArray = [CollectionsTypes] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arrayType = CollectionsTypes(collectionName: "Array")
        collectionArray.append(arrayType)
        let setType = CollectionsTypes(collectionName: "Set")
        collectionArray.append(setType)
        let dictionaryType = CollectionsTypes(collectionName: "Dictionary")
        collectionArray.append(dictionaryType)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifier")
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = collectionArray[indexPath.row].collectionName
        return cell!
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case [0,0]:
            performSegue(withIdentifier: "arrayIdentifier", sender: self)
        case [0,1]:
            performSegue(withIdentifier: "setIdentifier", sender: self)
        case [0,2]:
            performSegue(withIdentifier: "dictionaryIdentifier", sender: self)
        default:
            break
        }
     }
    
    
    
}


