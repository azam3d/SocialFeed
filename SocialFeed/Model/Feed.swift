
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
    let dateCreated: Date
//    let postType: PostType
    let title: String
    let likesCount: Int
    let commentCount: Int
//    let privacy: Privacy
    let profileImageUrl: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.dateCreated = json["date_created"].dateTime!
        self.title = json["title"].stringValue
        self.likesCount = json["likes_count"].intValue
        self.commentCount = json["comment_count"].intValue
        self.profileImageUrl = json["profile_image_url"].stringValue
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
    
}
