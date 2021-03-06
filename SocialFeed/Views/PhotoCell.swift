
import UIKit

class PhotoCell: UICollectionViewCell {
    
    var feed: Feed? {
        didSet {
            if let feed = feed {
                textLabel.text = feed.title
            }
        }
    }
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
    @IBOutlet weak var commentHitArea: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(commentPost))
//        commentHitArea.isUserInteractionEnabled = true
//        commentHitArea.addGestureRecognizer(tap)
    }
    
    @objc private func likePost() {
        print("like")
    }
    
    @objc private func commentPost() {
        print("comment")
    }
    
    @IBAction func openDetails(_ sender: Any) {
        print("open details")
    }
    
}
