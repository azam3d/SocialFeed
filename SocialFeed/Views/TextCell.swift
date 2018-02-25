
import UIKit

class TextCell: UICollectionViewCell {

    @IBOutlet weak var test: UIView!
    @IBOutlet weak var redBoxTapped: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openTest))
        test.isUserInteractionEnabled = true
        test.addGestureRecognizer(gesture)
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(openTest))
//        test.isUserInteractionEnabled = true
//        test.addGestureRecognizer(gesture)
    }
    
    @objc private func openTest() {
        print("test")
    }

    
}
