

import UIKit

class ArrayViewController: UIViewController {
    
    @IBOutlet weak var createArrayButton: UIButton!
    
    @IBOutlet weak var executionTimeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    let randomNumber = Int.random(in: 0...2000)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Array \(randomNumber)"
        activityIndicator.isHidden = true
    }

    func arrayCreation(numOfElements: Int) -> Double {
        let start = CFAbsoluteTimeGetCurrent()
        _ = Array(0...numOfElements)
         let diff = CFAbsoluteTimeGetCurrent() - start
        return Double(round(10000 * diff) / 10000)
    }
    
    func isWorkIndicator (isAnimated: Bool, indicator: UIActivityIndicatorView) {
        if isAnimated {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        }else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    @IBAction func createArray(_ sender: UIButton) {
        createArrayButton.setTitle("", for: [])
        isWorkIndicator(isAnimated: true, indicator: activityIndicator)
        Timer.scheduledTimer(withTimeInterval: arrayCreation(numOfElements: 9_999_999), repeats: false) {
            (t) in
            self.isWorkIndicator(isAnimated: false, indicator: self.activityIndicator)
            self.executionTimeLabel.text = "Array creation time: \(self.arrayCreation(numOfElements: (9_999_999))) seconds"
        }
    }
    
    
   




}

