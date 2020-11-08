import Foundation

//let dateFormatter = DateFormatter()
//dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//dateFormatter.dateFormat = "MM/dd/yy"

public final class DateHelper {
    // MARK: - Constants
    
    public enum Constants {
        public static let monthDayYearFormat = "MM/dd/yy"
        public static let fullDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    // MARK: - Private Properties
    
    private let calendar: Calendar
    private let currentDate: Date
    private let timeZone: TimeZone
    
    // MARK: - Initializers
    
    public init(calendar: Calendar = Calendar.current,
                currentDate: Date = Date(),
                timeZone: TimeZone = TimeZone.current) {
        self.calendar = calendar
        self.currentDate = currentDate
        self.timeZone = timeZone
    }
    
    // MARK: - Public Methods
    
    public func convertGraphQLDateToDate(_ graphQLDate: String?) -> Date? {
        guard let graphQLDate = graphQLDate else {
            return nil
        }
        
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = Constants.fullDateFormat

        var stringDate = graphQLDate
        
        let index = stringDate.index(stringDate.endIndex, offsetBy: -3)
        stringDate.remove(at: index)
        
        let date = formatter.date(from: stringDate)
        
        return date
    }
    
    public func convertDateToString(_ date: Date?,
                                 with format: String,
                                 using formatter: DateFormatter? = nil) -> String {
        
        guard let date = date else {
            return ""
        }
        
        let formatter = formatter ?? DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}
