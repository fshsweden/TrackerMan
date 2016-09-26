//
//  Request.swift
//  Trackerman
//
//  Created by Peter Andersson on 05/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation

class Request {
    let session: URLSession = URLSession.shared
    
    // GET METHOD
    func get(_ url: URL, completionHandler: (Data?, URLResponse?, NSError?) -> Void) {
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    // PUT METHOD
    func post(_ url: URL, body: NSMutableDictionary, completionHandler: (Data?, URLResponse?, NSError?) -> Void) {
        
        let str = "fshsweden@hotmail.com:wowu812"
        let utf8str = str.data(using: String.Encoding.utf8)

        let base64Encoded = utf8str!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        print("Encoded:  \(base64Encoded)")

        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic " + base64Encoded, forHTTPHeaderField: "Authorization")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.init(rawValue: 2))
        } catch {
            // Error Handling
            print("NSJSONSerialization Error")
            return
        }
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    // POST METHOD
    func put(_ url: URL, body: NSMutableDictionary, completionHandler: (Data?, URLResponse?, NSError?) -> Void) {
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.init(rawValue: 2))
        } catch {
            // Error Handling
            print("NSJSONSerialization Error")
            return
        }
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    // DELETE METHOD
    func delete(_ url: URL, completionHandler: (Data?, URLResponse?, NSError?) -> Void) {
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
