

import Foundation

struct ForecastRequest: RequestType {
    
    var baseUrl: URL = URL(string: "https://api.openweathermap.org/data/2.5")!
    var path: String = "/forecast"
    var method: String = "GET"
    var validStatusCode: [Int] = [200]
    
    var queryParameters: [String : String] = ["q" : "Cairo" , "appid" : "b7f1d80b093cadc7f43148b44aeb0060"]
    
    public let responseDecoder: (Data) throws -> [Forecast] = { data in
        try JSONDecoder().decode(ForecastResponse.self, from: data).convertToForecasts()
    }
    
}

// MARK: - Adapter Convetr from API responcr The model i use --> [Forecast]

// WeatherResponse struct to match the API response
struct  ForecastResponse: Decodable {
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
        case "clouds", "overcast":
            return .cloudy
        case "rain", "drizzle":
            return .rainy
        case "storm", "thunderstorm", "squall":
            return .stormy
        case "sun", "fair":
            return .sunny
        case "tornado":
            return .tornado
        case "wind", "breeze":
            return .windy
        case "snow":
            return .snowy
        case "mist":
            return .misty
        case "fog":
            return .foggy
        case "haze":
            return .hazy
        case "dust":
            return .dusty
        case "sandstorm":
            return .sandstorm
        case "ashfall":
            return .ashfall
        default:
            return .sunny // Or return .clear or even .cloudy, depending on your fallback preference
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
