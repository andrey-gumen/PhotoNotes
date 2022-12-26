import Foundation

extension Date {
    
    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }

    func getFormattedDate(_ format: String) -> String {
        let formatter = Date.getFormatter(format)
        return formatter.string(from: self)
    }
    
    private static func getFormatter(_ format: String = "dd MMM yyyy") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = format
        return formatter
    }

}
