import Foundation

/// Date: Specific point in time independent of any calendar / time zone
/// DateFormatter: Date to String to Date
/// DateComponents: Date / Time object represented in a particular calendar

let date = Date()
let tomorrow = Date.init(timeIntervalSinceNow: 86400)

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .full
dateFormatter.timeStyle = .full
dateFormatter.dateFormat = "MMM-dd-yyyy HH:mm"
let dateString = dateFormatter.string(from: date)

let dateStringer = "25/01/2011"
let anotherDateFormatter = DateFormatter()
anotherDateFormatter.dateFormat = "dd/MM/yyyy"
let dateFromString = anotherDateFormatter.date(from: dateStringer)

let calendar = Calendar.current
let components = calendar.dateComponents([.hour, .minute], from: date)
components.hour ?? 2

let newComponents = DateComponents(year: 2020, month: 6, day: 02)
let newDate = calendar.date(from: newComponents)

/// Literal Expressible

extension Date: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: IntegerLiteralType) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    self = formatter.date(from: String(value)) ?? Date()
  }
}

let testDate: Date = 2016_12_25
print(testDate)
