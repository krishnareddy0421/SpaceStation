//
//  ConnectionManager.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import Foundation

/**
 *  Enum for different HTTP Methods
 */
public enum HTTPMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
    case HEAD
}

/**
 *  Error codes
 */
public enum ErrorCode: Int {
    case noNetwork = 1001
    case userAuthFailed = 1002
    case searverFailuer = 1003
    case badRequest = 1004
    case tokenInvalid = 1005
}

public class ConnectionManager: NSObject, URLSessionDelegate {

    let kDomain = "com.Krishna-Kamjula.issspaces"
    let kContentType = "Content-Type"
    let kContentLength = "Content-Length"
    let kApplicationJson = "application/json"
    let kAccept = "Accept"
    
    var session = URLSession()
    var sessionConfiguration = URLSessionConfiguration()
    
    //Create shared instance
    public static let shared = ConnectionManager()
    
    //Initialize
    private override init() {
        sessionConfiguration = .default
        sessionConfiguration.urlCache = nil
        sessionConfiguration.httpMaximumConnectionsPerHost = 1
        sessionConfiguration.timeoutIntervalForRequest = 30
        session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
    }
    
    public func getResponse(urlString: String, params: [String: Any]?, completion connectionCompletion: @escaping (_ responseData: Data?, _ error: Error?) -> Void) {
        fetchResponse(urlString: urlString, params: params, methodType: HTTPMethod.GET, completion: connectionCompletion)
    }
    
    /**
     Declaration:
     
     func fetchResponse(urlString: String, messageBody postData: NSData?, methodType HTTPMethod: String, completion connectionCompletion: (responseData: AnyObject, response: NSHTTPURLResponse, error: NSError?) -> Void)
     
     Discussion
     
     The following function works for establishing the connection to web server
     
     */
    private func fetchResponse(urlString: String, params: [String: Any]?, methodType method: HTTPMethod, completion connectionCompletion: @escaping (_ responseData: Data?, _ error: Error?) -> Void) {
        
        //Check if Network is reachable or not
        if Reach().isNetworkReachable() == true {
            var apiRequest = URLRequest(url: URL(string: urlString)!)
            apiRequest.setValue(kApplicationJson, forHTTPHeaderField: kAccept)
            
            apiRequest.httpMethod = method.rawValue
            
            session.dataTask(with: apiRequest as URLRequest, completionHandler: {(data, response, error) -> Void in
                //print(String(data: data!, encoding: .utf8)!)
                if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        connectionCompletion(data, error as NSError?)
                    } else {
                        connectionCompletion(nil, self.handleError(statusCode: httpResponse.statusCode))
                    }
                } else {
                    print(error!)
                    let userInfo = self.createUserInfo("No Network availale", failureReason: "No Network")
                    let err = NSError(domain: self.kDomain, code: ErrorCode.noNetwork.rawValue, userInfo: userInfo)
                    connectionCompletion(nil, err as NSError)
                }
            }).resume()
            
        } else {
            let userInfo = self.createUserInfo("No Network availale", failureReason: "No Network")
            let error = NSError(domain: self.kDomain, code: ErrorCode.noNetwork.rawValue, userInfo: userInfo)
            connectionCompletion(nil, error)
        }
    }
    
    /**
     *  Converts an Int to Error to be handled appropriately
     */
    private func handleError(statusCode: Int) -> Error {
        var error: Error?
        switch statusCode {
        case 401:
            let userInfo = self.createUserInfo("User Authentication failed", failureReason: "User Authentication failed")
            error = NSError(domain: self.kDomain, code: ErrorCode.userAuthFailed.rawValue, userInfo: userInfo)
            
        case 412:
            let userInfo = self.createUserInfo("Token expired", failureReason: "Token expired")
            error = NSError(domain: self.kDomain, code: ErrorCode.tokenInvalid.rawValue, userInfo: userInfo)
            
        case 500:
            let userInfo = self.createUserInfo("Server failed", failureReason: "Server failed")
            error = NSError(domain: self.kDomain, code: ErrorCode.searverFailuer.rawValue, userInfo: userInfo)
            
        default:
            let userInfo = self.createUserInfo("Bad Request", failureReason: "Bad Request")
            error = NSError(domain: self.kDomain, code: ErrorCode.badRequest.rawValue, userInfo: userInfo)
        }
        
        return error!
    }

    /**
     *  Creates user info object that is used as part of error handler
     */
    private func createUserInfo(_ descriptionKey: String!, failureReason: String!) -> [String: Any] {
        
        return  [
            NSLocalizedDescriptionKey :  NSLocalizedString(descriptionKey, comment: failureReason) ,
            NSLocalizedFailureReasonErrorKey : NSLocalizedString(descriptionKey, comment: failureReason)
        ]
    }
}


