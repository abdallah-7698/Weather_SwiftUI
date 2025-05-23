
import Foundation

enum ForecastPeriod {
    case hourly
    case daily
}

enum Weather: String {
    case clear = "Clear"
    case cloudy = "Cloudy"
    case rainy = "Mid Rain"
    case stormy = "Showers"
    case sunny = "Sunny"
    case tornado = "Tornado"
    case windy = "Fast Wind"
    case snowy = "Snow"
    case misty = "Mist"
    case foggy = "Fog"
    case hazy = "Haze"
    case dusty = "Dust"
    case sandstorm = "Sandstorm"
    case ashfall = "Ashfall"
    case squall = "Squall"
}

struct Forecast: Identifiable {
    var id = UUID()
    var date: Date
    var weather: Weather
    var temperature: Int
    var high: Int
    var low: Int
    var location: String
    
    var icon: String {
        switch weather {
        case .clear:
            return "Sun"
        case .cloudy, .misty, .hazy, .foggy:
            return "Sun cloud"
        case .rainy, .stormy, .squall, .tornado:
            return "Cloud little rain"
        case .sunny:
            return "Sun"
        case .windy:
            return "Sun fast wind"
        case .snowy:
            return "Sun cloud slow wind"
        case .dusty, .sandstorm, .ashfall:
            return "Tornado"
        }
    }
    
}

// MARK:- Mock Data

extension Forecast {
    static let hour: TimeInterval = 60 * 60
    static let day: TimeInterval = 60 * 60 * 24
    
    static let hourly: [Forecast] = [
        Forecast(date: .init(timeIntervalSinceNow: hour * -1), weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .now, weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: hour * 1), weather: .windy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: hour * 2), weather: .rainy, temperature: 18, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: hour * 3), weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: hour * 4), weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada")
    ]
    
    static let daily: [Forecast] = [
        Forecast(date: .init(timeIntervalSinceNow: 0), weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: day * 1), weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: day * 2), weather: .stormy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: day * 3), weather: .stormy, temperature: 18, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: day * 4), weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .init(timeIntervalSinceNow: day * 5), weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada")
    ]
    
    static let cities: [Forecast] = [
        Forecast(date: .now, weather: .rainy, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .now, weather: .windy, temperature: 20, high: 21, low: 19, location: "Toronto, Canada"),
        Forecast(date: .now, weather: .stormy, temperature: 13, high: 16, low: 8, location: "Tokyo, Japan"),
        Forecast(date: .now, weather: .tornado, temperature: 23, high: 26, low: 16, location: "Tennessee, United States")
    ]
}
