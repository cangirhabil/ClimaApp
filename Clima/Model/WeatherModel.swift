//
//  WeatherModel.swift
//  Clima
//
//  Created by admin on 29.07.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel{
    let conditionID: Int?
    let cityName: String?
    let temparature: Double?
    
    var temparatureString: String?{
        if let safeTemparature = self.temparature{
            return String(format: "%.1f", safeTemparature)
        }else{
            return "24.0"
        }
    }
    
    var condationName: String? {
        if let safeConditionID = conditionID{
            switch safeConditionID {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            }
        }else{
            return "sun.max"
        }
    }
}
