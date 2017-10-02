
import Moya

enum FeedService {
    case showPost
}

extension FeedService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.instance.com.sg/api/v1")!
    }
    
    var path: String {
        switch self {
        case .showPost:
            return "/posts/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .showPost:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .showPost:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .showPost:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json", "Authorization": "Bearer VT9MM4rynnIQtXGe5XRTzePQevLHA3"]
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
