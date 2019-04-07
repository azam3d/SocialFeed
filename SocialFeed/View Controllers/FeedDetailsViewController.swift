
import UIKit

final class FeedDetailsViewController: UIViewController {
    
    @IBOutlet weak var stickyTextView: UITextView!
    @IBOutlet weak var heroImage: UIImageView!
    private var errorText = "No feed."
    
    var combine = [Any]()
//    var comments = [Comment]()
//    var post: PostProperty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Feed Details", comment: "Title for FeedDetailsVC")
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openImageVC))
        heroImage.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func openImageVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let imageVC = storyboard.instantiateViewController(withIdentifier: Constants.storyboards.imageVC) as? ImageViewController else {
            fatalError("Could not instantiate view controller createPostVC")
        }
        navigationController?.present(imageVC, animated: true, completion: nil)
    }
    
}
