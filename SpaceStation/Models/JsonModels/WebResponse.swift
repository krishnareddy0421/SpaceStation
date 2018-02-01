//
//  WebResponse.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import Foundation

// Model relaed to response
class WebResponse: Codable {
    let message: String
    let request: Request
    let response: [Response]
}
