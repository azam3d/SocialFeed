
import Foundation
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
//    let dateCreated: Date
//    let postType: PostType
    let title: String
//    let likesCount: Int
//    let commentCount: Int
//    let privacy: Privacy
//    let profileImageUrl: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true //(object as? Feed)?.id == self.id
    }
    
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case dateCreated = "date_created"
//        case postType = "post_type"
//        case title
//        case likesCount = "likes_count"
//        case commentCount = "comment_count"
//        case privacy
//        case profileImageUrl = "profile_image_url"
//    }
}
