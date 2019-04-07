
import Moya
import SwiftyJSON
import UIKit

final class FeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            collectionView.refreshControl = refreshControl
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData),
                                 for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    var feeds = [Feed]()
    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = CGSize(width: view.bounds.width, height: 142)
//        layout.itemSize = CGSize(width: view.bounds.width, height: 142)
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
//        return collectionView
//    }()
    var errorText = "No feed."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self

        navigationItem.title = NSLocalizedString("Feed", comment: "Title for FeedVC")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPost))

        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        feeds = []
    }

    @objc private func fetchData() {
        let provider = MoyaProvider<FeedService>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.showPostFiltered(albumId: 1)) { [weak self] result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data

                let json = JSON(data)
                dump(json)

                for (_, subJson): (String, JSON) in json {
                    if subJson["title"].stringValue != "" {
                        self?.feeds.append(Feed(json: subJson))
                    }
                }
                self?.collectionView.reloadData()
                self?.refreshControl.endRefreshing()
            case let .failure(error):
                print("error")
                print(error.errorDescription!)
                self?.errorText = "The Internet connection appears to be offline."
            }
        }
    }

    @objc private func createPost() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let createPostVC = storyboard.instantiateViewController(withIdentifier: Constants.storyboards.createPost) as? CreatePostViewController else {
            fatalError("Could not instantiate view controller createPostVC")
        }
        navigationController?.present(createPostVC, animated: true, completion: nil)
    }

//    func emptyView(for listAdapter: ListAdapter) -> UIView? {
//        let emptyLabel = UILabel(frame: CGRect(x: (view.bounds.width / 2) - 150, y: (view.bounds.height / 2) - 15, width: 300, height: 70))
//        emptyLabel.text = errorText
//        emptyLabel.textAlignment = .center
//        emptyLabel.textColor = UIColor.lightGray
//
//        let emptyView = UIView(frame: self.view.bounds)
//        emptyView.addSubview(emptyLabel)
//
//        return emptyView
//    }
    
    @objc func likePost() {
        print("comment")
    }
    
}

extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.nib.photoCell, for: indexPath) as? PhotoCell else {
            fatalError()
        }
        photoCell.feed = feeds[indexPath.row]
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(likePost))
        photoCell.commentHitArea.isUserInteractionEnabled = true
        photoCell.commentHitArea.addGestureRecognizer(gesture)

        if let url = URL(string: feeds[indexPath.row].url) {
            photoCell.profileImageView.downloadedFrom(url: url)
        } else {
            photoCell.profileImageView.image = UIImage(named: "ic_comment")
        }
        return photoCell
    }
    
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 180.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40.0
    }
    
}
