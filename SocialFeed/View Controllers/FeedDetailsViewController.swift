
import UIKit

final class FeedDetailsViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 375, height: 142)
        layout.itemSize = CGSize(width: 375, height: 142)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return collectionView
    }()
    @IBOutlet weak var stickyTextView: UITextView!
    var errorText: String? = "No feed."
    @IBOutlet weak var heroImage: UIImageView!
    
    var combine = [Any]()
//    var comments = [Comment]()
//    var post: PostProperty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openImageVC))
        heroImage.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func openImageVC() {
        let vc = ImageViewController()
        present(vc, animated: true, completion: nil)
    }
    
}
