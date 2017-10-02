
import IGListKit

final class FeedSectionController: ListSectionController {
    
    var data: String!
    
    override init() {
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = CGFloat(44)
        let width = collectionContext?.containerSize.width ?? 0
        
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let photoCell = collectionContext!.dequeueReusableCell(withNibName: "PhotoCell", bundle: nil, for: self, at: index) as! PhotoCell
        photoCell.textLabel.text = data
        return photoCell
    }
    
    override func didUpdate(to object: Any) {
        data = object as? String
    }
    
    override func didSelectItem(at index: Int) { }
    
}
