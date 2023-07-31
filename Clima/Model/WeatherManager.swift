import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error?)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=37c29bad1119f567393b9bb290e02fec&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    
    func adjustWord(word : String) -> String{
        var cityName = word
        var cityNameString = String()
        for letter in cityName{
            switch letter{
            case "İ":
                cityNameString += "i"
                break
            case "ı":
                cityNameString += "i"
                break
            case "ğ":
                cityNameString += "g"
                break
            case "ş":
                cityNameString += "s"
                break
            case "ü":
                cityNameString += "u"
                break
            case "ö":
                cityNameString += "o"
                break
            default:
                cityNameString += "\(letter)"
            }
        }
        return cityNameString
    }
    
    func fetchWheather(cityName: String){
        let citynameString = adjustWord(word: cityName)
        let urlString = "\(weatherURL)&q=\(citynameString)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWheather(langitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlSetring = "\(weatherURL)&lat=\(langitude)&lon=\(longitude)"
        performRequest(with: urlSetring)
    }
    
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respone, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(weatherManager: self, weather: weather)
                    }
                }
            }
            task.resume()
        }else{
            print("aaaa")
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        do{
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
            let ID = decodedData.weather[0]?.id
            let temp = decodedData.main?.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionID: ID, cityName: name, temparature: temp)
            return weather
            
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}


