
import Moya
import SwiftyJSON
/*
struct Network {
    static let provider = MoyaProvider<FeedService>(endpointClosure: endpointClosure)
    
    static func request(
        target: FeedService,
        success successCallback: (JSON) -> Void,
        error errorCallback: (Int) -> Void,
        failure failureCallback: (MoyaError) -> Void
        ) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    successCallback(json)
                }
                catch error {
                    errorCallback(error)
                }
            case let .failure(error):
                if target.shouldRetry {
                    retryWhenReachable(target, successCallback, errorCallback, failureCallback)
                }
                else {
                    failureCallback(error)
                }
            }
        }
    }
}
*/
