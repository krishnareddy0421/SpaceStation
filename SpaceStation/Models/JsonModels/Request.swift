//
//  Request.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import Foundation

// Model related to response parameter in "request" of webservice
class Request: Codable {
	let altitude: Int
	let datetime: Int
	let latitude: Double
	let longitude: Double
	let passes: Int
}
