
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
    
    enum State: String {
        case loading, loaded, empty, error
    }
    enum PostType {
        case photo, text
    }
    var state: State! {
        didSet {
            render()
        }
    }
    var feeds = [Feed]()
    var errorText = "No feed."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        navigationItem.title = NSLocalizedString("Feed", comment: "Title for FeedVC")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPost))

        state = .loading
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
    
    private func render() {
        guard let state = state else {
            fatalError()
        }
        switch state {
        case .loading:
            print("loading")
        case .loaded:
            print("loaded")
            refreshControl.endRefreshing()
        case .empty:
            print("empty")
        case .error:
            print("error")
            view = emptyView()
        }
    }

    @objc private func fetchData() {
        let provider = MoyaProvider<FeedService>(/*plugins: [NetworkLoggerPlugin(verbose: false)]*/)
        provider.request(.showPostFiltered(albumId: 1)) { [weak self] result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data

                let json = JSON(data)
//                dump(json)

                for (_, subJson): (String, JSON) in json {
                    if subJson["title"].stringValue != "" {
                        self?.feeds.append(Feed(json: subJson))
                    }
                }
                self?.state = .loaded
                self?.collectionView.reloadData()
            case let .failure(error):
                self?.state = .error
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

    private func emptyView() -> UIView? {
        let emptyLabel = UILabel(frame: CGRect(x: (view.bounds.width / 2) - 150, y: (view.bounds.height / 2) - 15, width: 300, height: 70))
        emptyLabel.text = errorText
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = UIColor.lightGray

        let emptyView = UIView(frame: self.view.bounds)
        emptyView.addSubview(emptyLabel)

        return emptyView
    }
    
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
        return 12.0
    }
    
}
