

import Foundation

struct WeatherRequest: RequestType {
    
    var baseUrl: URL = URL(string: "https://api.openweathermap.org/data/2.5")!
    var path: String = "/forecast"
    var method: String = "GET"
    var validStatusCode: [Int] = [200]
    
    var queryParameters: [String : String] = ["q" : "Cairo" , "appid" : "b7f1d80b093cadc7f43148b44aeb0060"]
    
    public let responseDecoder: (Data) throws -> [Forecast] = { data in
        try JSONDecoder().decode(WeatherResponse.self, from: data).convertToForecasts()
    }
    
}

// MARK: - Adapter Convetr from API responcr The model i use --> [Forecast]
// WeatherResponse struct to match the API response
struct WeatherResponse: Decodable {
    struct City: Decodable {
        var name: String
    }
    struct WeatherInfo: Decodable {
        var main: String
        var description: String
    }
    struct Main: Decodable {
        var temp: Double
        var temp_max: Double
        var temp_min: Double
    }
    
    var list: [WeatherData]
    var city: City
    
    struct WeatherData: Decodable {
        var dt: Int
        var main: Main
        var weather: [WeatherInfo]
    }
    
    // Method to map Weather description to Weather enum
    func weatherFromDescription(_ description: String) -> Weather {
        switch description.lowercased() {
        case "clear":
            return .clear
        case "clouds":
            return .cloudy
        case "rain":
            return .rainy
        case "storm", "thunderstorm":
            return .stormy
        case "sun", "fair":
            return .sunny
        case "tornado":
            return .tornado
        case "wind":
            return .windy
        case "snow":
            return .snowy
        case "mist", "fog":
            return .cloudy // You can choose to return cloudy here or a separate case like "foggy" if you prefer
        case "haze":
            return .cloudy // Same as fog, could be treated similarly
        case "dust", "sandstorm", "ashfall":
            return .dusty
        case "squall":
            return .stormy
        case "drizzle":
            return .rainy
        default:
            return .sunny // Defaulting to sunny if the description is unknown
        }
    }
    
    // Method to convert WeatherResponse to an array of Forecasts
    func convertToForecasts() -> [Forecast] {
        return list.map { data in

            // Get the main weather description and convert it to the Weather enum
            let weatherDescription = data.weather.first?.main ?? ""
            let weather = weatherFromDescription(weatherDescription)
            
            return Forecast(
                date: data.dt.toDate(),
                weather: weather,
                temperature: Int(data.main.temp.toCelsius()),
                high: Int(data.main.temp_max.toCelsius()),
                low: Int(data.main.temp_min.toCelsius()),
                location: city.name
            )
        }
    }
}
