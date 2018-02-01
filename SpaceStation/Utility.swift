//
//  Utility.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import Foundation

class Utility {
    /**
     * Convert timeStamp seconds to formatted date string
     */
    static func getTimeStamp(for timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        return dateFormatter.string(from: date)
    }
    
    /**
     * Converts the duration seconds to proper minutes and seconds
     */
    static func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        return "\( (seconds % 3600) / 60)m : \((seconds % 3600) % 60)s"
    }
}
