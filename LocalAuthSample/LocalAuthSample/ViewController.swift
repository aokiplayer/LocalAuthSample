import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var authResultLabel: UILabel!
    
    @IBAction func authenticate(_ sender: UIButton) {
        let myContext = LAContext()
        self.configure(context: myContext)
        let reason = "Only device owner can use this feature."

        var authError: NSError? = nil

        // Touch ID enabled?
        if myContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {

            // perform authentication.
            myContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, evaluateError) in
                if success {
                    print("Success")

                    DispatchQueue.main.async {
                        self.authResultLabel.text = "Success"
                    }
                } else {
                    let error = evaluateError! as NSError
                    let errorMessage = "\(error.code): \(error.localizedDescription)"

                    print(errorMessage)

                    DispatchQueue.main.async {
                        self.authResultLabel.text = errorMessage
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// customize button titles.
    private func configure(context: LAContext) {
        context.localizedCancelTitle = "Cancel"
        context.localizedFallbackTitle = "Enter Passcode"
    }
}
