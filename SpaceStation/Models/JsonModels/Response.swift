//
//  Response.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import Foundation

// Model related to response parameter in "response" of webservice
class Response: Codable {
	let duration: Int
	let risetime: Int
}
