
import IGListKit
import Moya
import UIKit
import SwiftyJSON

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
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var feed = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.refreshControl = refreshControl
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
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
                do {
                    try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try moyaResponse.mapJSON()
                    let json = JSON(data)
                    
                    for (_, subJson): (String, JSON) in json {
                        if subJson["title"].stringValue != "" {
                            self.feed.append(Feed(id: subJson["id"].intValue, title: subJson["title"].stringValue))
                        }
                    }
                    self.adapter.performUpdates(animated: true, completion: nil)
                    self.refreshControl.endRefreshing()
                }
                catch {
                    print("catch error")
                }
            case let .failure(error):
                print("error")
                print(error.errorDescription!)
            }
        }
    }
    
    @objc private func createPost() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Feed Details") as! FeedDetailsViewController
        navigationController?.pushViewController(vc, animated: true)
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
        return nil
    }
    
}
