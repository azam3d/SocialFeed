
import IGListKit
import UIKit

class FeedDetailsViewController: UIViewController {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
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
    
    var combine = [Any]()
//    var comments = [Comment]()
//    var post: PostProperty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FeedDetailsViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return combine as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FeedSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let emptyView = UIView(frame: self.view.bounds)
        let emptyLabel = UILabel(frame: CGRect(x: (view.bounds.width / 2) - 150, y: (view.bounds.height / 2) - 15, width: 300, height: 70))
        emptyLabel.text = errorText
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = UIColor.lightGray
        emptyView.addSubview(emptyLabel)
        
        return emptyView
    }
    
}
