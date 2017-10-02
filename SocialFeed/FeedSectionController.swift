
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
        let photoCell = collectionContext!.dequeueReusableCell(withNibName: "PhotoCell", bundle: nil, for: self, at: index) as! PhotoCell
        photoCell.textLabel.text = feed.title
        return photoCell
    }
    
    override func didUpdate(to object: Any) {
        dump(object)
        feed = object as? Feed
    }
    
    override func didSelectItem(at index: Int) { }
    
}