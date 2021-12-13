

import UIKit

class SetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var allMatchingLettersLabel: UILabel!
    @IBOutlet weak var notMatchingLettersLabel: UILabel!
    
    let randomNumber = Int.random(in: 0...2000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextField.becomeFirstResponder()
        self.navigationItem.title = "Set \(randomNumber)"
        
    }
    
    
    func notMatchingLetters(first: String, second: String) -> String {
        let notMatchingResult = String(Set(first).symmetricDifference(Set(second)))
        return notMatchingResult
    }
    
    func matchingLetters(first: String, second: String) -> String {
        let matchingResult = String(Set(first).intersection(Set(second)))
        return matchingResult
    }
    
    func matchingResultOut(text1: String, text2: String) {
        let resultIntoLabel = matchingLetters(first: text1, second: text2)
        allMatchingLettersLabel.text = "\(resultIntoLabel)"
    }
    
    func notMatchingResultOut (text1: String, text2: String) {
        let resultIntoLabel = notMatchingLetters(first: text1, second: text2)
        notMatchingLettersLabel.text = "\(resultIntoLabel)"
    }
    

    
    @IBAction func allMatchingLetters(_ sender: UIButton) {
        matchingResultOut(text1: firstTextField.text ?? "" , text2: secondTextField.text ?? "")
    }
    
    @IBAction func notMatchingLetters(_ sender: UIButton) {
        notMatchingResultOut(text1: firstTextField.text ?? "" , text2: secondTextField.text ?? "")
    }
    
}
