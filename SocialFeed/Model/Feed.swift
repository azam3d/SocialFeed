
import IGListKit
import SwiftyJSON

enum PostType {
    case text
    case image
    case video
}

enum Privacy {
    case publicPost
    case privatePost
}

final class Feed: ListDiffable {
    let id: Int
    let title: String
    let url: String
    let albumId: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.url = json["url"].stringValue
        self.albumId = json["albumId"].intValue
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
    
}
