

import UIKit

class SetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var allMatchingLettersLabel: UILabel!
    @IBOutlet weak var notMatchingLettersLabel: UILabel!
    @IBOutlet weak var allUniqueCharsFirstTFLabel: UILabel!
    
    let randomNumber = Int.random(in: 0...2000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextField.becomeFirstResponder()
        self.navigationItem.title = "Set \(randomNumber)"
        firstTextField.delegate = self
        secondTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//    only letters func
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != "" else {return true}
        return onlyLetters(string: string)
    }

    func onlyLetters(string: String) -> Bool {
        let leftSideField = CharacterSet.decimalDigits
        let rightSideField = CharacterSet(charactersIn: string)
        return !leftSideField.isSuperset(of: rightSideField)
    }
    
    
//    functions
    
    func notMatchingLetters(first: String, second: String) -> String {
        let notMatchingResult = String(Set(first).symmetricDifference(Set(second)))
        return notMatchingResult
    }
    
    func matchingLetters(first: String, second: String) -> String {
        let matchingResult = String(Set(first).intersection(Set(second)))
        return matchingResult
    }
    
    func uniqueCharsInFirstTF (first: String) -> String {
        let uniqueResult = String(Set(first))
        return uniqueResult
    }
    
    
//    result out functions
    
    func matchingResultOut(text1: String, text2: String) {
        let resultIntoLabel = matchingLetters(first: text1, second: text2)
        allMatchingLettersLabel.text = "\(resultIntoLabel)"
    }
    
    func notMatchingResultOut(text1: String, text2: String) {
        let resultIntoLabel = notMatchingLetters(first: text1, second: text2)
        notMatchingLettersLabel.text = "\(resultIntoLabel)"
    }
    
    func uniqueCharsResultOut(text1: String) {
        let resultIntoLabel = uniqueCharsInFirstTF(first: text1)
        allUniqueCharsFirstTFLabel.text = "\(resultIntoLabel)"
    }

    
//    action functions
    
    @IBAction func allMatchingLetters(_ sender: UIButton) {
        matchingResultOut(text1: firstTextField.text ?? "" , text2: secondTextField.text ?? "")
    }
    
    @IBAction func notMatchingLetters(_ sender: UIButton) {
        notMatchingResultOut(text1: firstTextField.text ?? "" , text2: secondTextField.text ?? "")
    }
    
    @IBAction func allUniqueCharsFirstTF(_ sender: UIButton) {
        uniqueCharsResultOut(text1: firstTextField.text ?? "")
    }
    
    
}
