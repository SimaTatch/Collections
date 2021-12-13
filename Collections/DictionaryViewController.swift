//
//  DictionaryViewController.swift
//  Collections
//
//  Created by Серафима  Татченкова  on 11.12.2021.
//

import UIKit

class DictionaryViewController: UIViewController {

    let randomNumber = Int.random(in: 0...2000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Dictionary \(randomNumber)"
        
 
    }


}
