
import IGListKit

final class FeedSectionController: ListSectionController {
    
    var feed: Feed!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = CGFloat(142)
        let width = collectionContext?.containerSize.width ?? 0
        
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let photoCell = collectionContext!.dequeueReusableCell(withNibName: Constants.Nib.photoCell, bundle: nil, for: self, at: index) as! PhotoCell
        photoCell.feed = feed
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(likePost))
//        photoCell.commentHitArea.isUserInteractionEnabled = true
//        photoCell.commentHitArea.addGestureRecognizer(gesture)
        
        if let url = URL(string: feed.url) {
            print("feed url: ")
            print(feed.url)
            photoCell.profileImageView.downloadedFrom(url: url)
        } else {
            photoCell.profileImageView.image = UIImage(named: "ic_commnet")
        }
        return photoCell
    }
    
    override func didUpdate(to object: Any) {
        feed = object as? Feed
    }
    
//    override func didSelectItem(at index: Int) { }
    
    @objc func likePost() {
        print("comment")
    }
    
}
