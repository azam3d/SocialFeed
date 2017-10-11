
import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.setRounded()
        }
    }
    @IBOutlet weak var dateCreated: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var likeHitArea: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(likePost))
            likeHitArea.isUserInteractionEnabled = true
            likeHitArea.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var commentHitArea: UIView! {
        didSet {
//            let gesture = UITapGestureRecognizer(target: self, action: #selector(likePost))
//            commentHitArea.isUserInteractionEnabled = true
//            commentHitArea.addGestureRecognizer(gesture)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likePost))
        commentHitArea.isUserInteractionEnabled = true
        commentHitArea.addGestureRecognizer(tap)
    }
    
    @objc private func likePost() {
        print("like")
    }
    
}
