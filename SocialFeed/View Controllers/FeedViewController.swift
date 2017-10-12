
import IGListKit
import Moya
import SwiftyJSON
import UIKit

class FeedViewController: UIViewController {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData),
                                 for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 375, height: 142)
        layout.itemSize = CGSize(width: 375, height: 142)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    var errorText: String? = "No feed."
    
    var feed = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        navigationItem.title = "Feed"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPost))
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func fetchData() {
        let provider = MoyaProvider<FeedService>()
        provider.request(.showPost) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                
                let json = JSON(data)
//                dump(json)
                for (_, subJson): (String, JSON) in json {
                    if subJson["title"].stringValue != "" {
                        self.feed.append(Feed(json: subJson))
                    }
                }
                self.adapter.performUpdates(animated: true, completion: nil)
                self.refreshControl.endRefreshing()
            case let .failure(error):
                print("error")
                print(error.errorDescription!)
                self.errorText = "The Internet connection appears to be offline."
                self.adapter.performUpdates(animated: true, completion: nil)
            }
        }
    }
    
    @objc private func createPost() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let createPostVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.createPost) as? CreatePostViewController else {
            fatalError("Could not instantiate view controller createPostVC")
        }
        navigationController?.present(createPostVC, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        feed = []
    }
    
}

extension FeedViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return feed as [ListDiffable]
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
