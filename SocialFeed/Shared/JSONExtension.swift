
import SwiftyJSON

extension JSON {
    
    public var dateTime: Date? {
        get {
            switch self.type {
            case .string:
                return ServerDateFormatter.date(from: self.object as! String)
            default:
                return nil
            }
        }
    }
    
    public var dateTimeValue: Date {
        return self.dateTime ?? Date()
    }
    
}
