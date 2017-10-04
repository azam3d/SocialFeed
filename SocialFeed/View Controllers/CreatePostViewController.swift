
import UIKit

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.setRounded()
        }
    }
    @IBOutlet weak var displayNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }

    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPost(_ sender: Any) {
        print("Submit post")
    }
    

}
