//
//  APIManager.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import Foundation

/**
 *  APIManager is a class that handles how to form web service requests and handle the response.
 */
class APIManager {
    /**
     *  Fetch the connections based on the search strings based on From & To text entered by user
     *  Forms the URL, calls the web request, parse the received JSON and return the data appropriately
     */
    static func fetchISSPasses(latitude: Double, longitude: Double, onComplete: @escaping (_ received: WebResponse?) -> Void)  {
        //Prepare the URL
        let url = "http://api.open-notify.org/iss-pass.json?lat=\(latitude)&lon=\(longitude)"

        //Fetch the response from Connection manager class
        ConnectionManager.shared.getResponse(urlString: url, params: nil) { (receivedData, error) in
            if error == nil, let data = receivedData {
                //parse received data
                do {
                    //Use Swift4 Codable to decode JSON object into model
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(WebResponse.self, from: data)
                    onComplete(response)
                } catch {
                    print("Failed to decode to json: \(error.localizedDescription)")
                    onComplete(nil)
                }
            } else {
                //Return empty arry of connections when error occurs
                print("Error in parsing: \(error?.localizedDescription ?? "")")
                onComplete(nil)
            }
        }
    }
}
