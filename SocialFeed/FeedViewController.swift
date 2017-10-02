
import Alamofire
import IGListKit
import Moya
import UIKit

class FeedViewController: UIViewController {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var data = ["Baby", "Mummy", "Daddy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        navigationItem.title = "Feed"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        fetchData()
    }
    
    private func fetchData() {
        let provider = MoyaProvider<FeedService>()
        provider.request(.showPost) { result in
            switch result {
            case let .success(moyaResponse):
                print("success")
                dump(moyaResponse)
                
                do {
                    try moyaResponse.filterSuccessfulStatusCodes()
                    let data2 = try moyaResponse.mapJSON()
                    print(data2)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        data = []
    }
    
}

extension FeedViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FeedSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
