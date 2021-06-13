import Foundation

class Converter {
    static private let dateFormatter = DateFormatter()
    
    static var instance: Converter = {
        let instance = Converter()
        return instance
    }()
    
    private init() {}
    
    static func convertUnixDateToStringDate(unixDate: String) -> String{
        var localDate = ""
        if let timeResult = Double(unixDate) {
            let date = Date(timeIntervalSince1970: timeResult)
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateFormatter.timeZone = .current
            localDate = dateFormatter.string(from: date)
        }
        return localDate
    }
    
}
extension Converter: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
