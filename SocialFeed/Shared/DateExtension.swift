
import Foundation

public typealias Timestamp = UInt64
public typealias MicrosecondTimestamp = UInt64

public let threeWeeksInSeconds = 3 * 7 * 24 * 60 * 60

public let oneSecondInMilliseconds: UInt64 = 1000
public let oneMinuteInMilliseconds = 60 * oneSecondInMilliseconds
public let oneHourInMilliseconds = 60 * oneMinuteInMilliseconds
public let oneDayInMilliseconds = 24 * oneHourInMilliseconds
public let oneWeekInMilliseconds = 7 * oneDayInMilliseconds
public let oneMonthInMilliseconds = 30 * oneDayInMilliseconds

extension Date {
    public static func now() -> Timestamp {
        return UInt64(1000 * Date().timeIntervalSince1970)
    }
    
    public static func nowNumber() -> NSNumber {
        return NSNumber(value: now())
    }
    
    public static func nowMicroseconds() -> MicrosecondTimestamp {
        return UInt64(1000000 * NSDate().timeIntervalSince1970)
    }
    
    public static func fromTimestamp(timestamp: Timestamp) -> Date {
        return Date(timeIntervalSince1970: Double(timestamp) / 1000)
    }
    
    public static func fromMicrosecondTimestamp(microsecondTimestamp: MicrosecondTimestamp) -> Date {
        return Date(timeIntervalSince1970: Double(microsecondTimestamp) / 1000000)
    }
    
    public static func getCurrent() -> String {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        return formatter.string(from: date)
    }
    
    public func toRelativeTimeString(showTime: Bool = false) -> String {
        let now = Date()
        let component = Set<Calendar.Component>([.hour, .year, .month, .weekOfYear, .day, .minute, .second])
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = calendar.dateComponents(component, from: self, to: now)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = showTime ? "d MMMM yy 'at' h:mm a" : "d MMMM yy"
        
        if components.year! > 0 {
            return dateFormatter.string(from: self as Date)
        }
        
        if components.month! > 1 {
            return dateFormatter.string(from: self as Date)
        }
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let time = dateFormatter.string(from: self as Date)
        
        if components.month == 1 {
            return showTime ? "1 month ago at \(time)" : "1 month ago"
        }
        
        if components.weekOfYear! > 1 && components.weekOfYear! < 4 {
            return showTime ? "\(components.weekOfYear!) weeks ago at \(time)" : "\(components.weekOfYear!) weeks ago"
        }
        
        if components.weekOfYear == 1 {
            return showTime ? "\(components.weekOfYear!) week ago at \(time)" : "\(components.weekOfYear!) week ago"
        }
        
        if components.day! > 1 {
            return showTime ? "\(components.day!) days ago at \(time)" : "\(components.day!) days ago"
        }
        
        if components.day == 1 {
            return showTime ? "Yesterday at \(time)" : "Yesterday"
        }
        
        if components.hour! > 1 {
            return "\(components.hour!) hours ago"
        }
        
        if components.hour! == 1 {
            return "1 hour ago"
        }
        
        if components.minute! > 1 {
            return "\(components.minute!) minutes ago"
        }
        
        if components.minute == 1 {
            return "1 minute ago"
        }
        return "Just now"
    }
    
    public func toString(formatter: DateFormatter = ServerDateFormatter) -> String {
        return formatter.string(from: self)
    }
}

extension String {
    public func toDate(formatter: DateFormatter = ServerDateFormatter) -> Date? {
        return formatter.date(from: self)
    }
    
    public func toDateString(showTime: Bool = false) -> String? {
        guard let date = self.toDate() else {
            return nil
        }
        return date.toRelativeTimeString(showTime: showTime)
    }
}

public let ServerDateFormatter: DateFormatter = {
    let result = DateFormatter()
    result.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
    result.timeZone = TimeZone(abbreviation: "UTC")
    return result
}()
