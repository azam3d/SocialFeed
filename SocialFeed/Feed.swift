
import Foundation

enum PostType: String, Codable {
    case text
    case image
    case video
}

enum Privacy: String, Codable {
    case publicPost
    case privatePost
}

struct Feed: Decodable {
    let id: Int
    let dateCreated: Date
    let postType: PostType
    let title: String
    let likesCount: Int
    let commentCount: Int
    let privacy: Privacy
    let profileImageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case dateCreated = "date_created"
        case postType = "post_type"
        case title
        case likesCount = "likes_count"
        case commentCount = "comment_count"
        case privacy
        case profileImageUrl = "profile_image_url"
    }
}
