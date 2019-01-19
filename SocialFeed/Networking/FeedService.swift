
import Moya

enum FeedService {
    case showPost
    case showPostFiltered(albumId: Int?)
}

extension FeedService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .showPost:
            return "/posts"
        case .showPostFiltered:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .showPost, .showPostFiltered:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .showPost:
            return .requestPlain
        case .showPostFiltered(let albumId):
            var params: [String: Any] = [:]
            params["albumId"] = albumId
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .showPost, .showPostFiltered:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}

private extension String {
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
}
