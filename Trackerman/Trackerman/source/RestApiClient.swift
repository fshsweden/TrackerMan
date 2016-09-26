//
//  RestApiManager.swift
//  SimpleGPSTest
//
//  Created by Peter Andersson on 02/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

public enum RestError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

/*  ----------------------------------------------------------------------------------
 
 
 
    ----------------------------------------------------------------------------------
 */
class RestApiClient: NSObject {
    static let sharedInstance = RestApiClient()

    let getRandomUserURL        = "http://api.randomuser.me/"
    let getUsersURL             = "http://valbo.dnsalias.com:9999/get_users"
    let getZonesURL             = "http://valbo.dnsalias.com:9999/get_zones"
    let getTreasuresWithinURL   = "http://valbo.dnsalias.com:9999/get_treasures_within"
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func getRandomUser(_ onCompletion: @escaping (JSON) -> Void) {
        let route = getRandomUserURL
        makeHTTPGetRequest(route, user: "fshsweden@hotmail.com", password:"wowu812", onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }

    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func getTreasures(
        _ lat: Double,
        lng: Double,
        maxdist : Double,
        onCompletion: @escaping (JSON) -> Void) {
        let route = getTreasuresWithinURL + "?lat=\(lat);lng=\(lng);maxdist=\(maxdist)";
        makeHTTPGetRequest(route, user: "fshsweden@hotmail.com", password:"wowu812", onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    
    
    
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func makeHTTPGetRequest(_ path: String, user:String, password:String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: URL(string: path)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func HTTPPostJSON(_ url: String,  user:String, password:String, data: Data, callback: @escaping (String, String?) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")

        let str = "\(user):\(password)"
        
        // UTF 8 str from original
        // NSData! type returned (optional)
        let utf8str = str.data(using: String.Encoding.utf8)
        
        // Base64 encode UTF 8 string
        // fromRaw(0) is equivalent to objc 'base64EncodedStringWithOptions:0'
        // Notice the unwrapping given the NSData! optional
        // NSString! returned (optional)
        let base64Encoded = utf8str!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        print("Email:  \(user)")
        print("Passwd:  \(password)")
        print("Encoded:  \(base64Encoded)")
        print("Result: Basic \(base64Encoded)")
        
        request.setValue("Basic \(base64Encoded)",forHTTPHeaderField: "Authorization")
        
        request.httpBody = data
        HTTPsendRequest(request, base64EncodedCredential: base64Encoded, callback: callback)
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func HTTPsendRequest(_ request: NSMutableURLRequest, base64EncodedCredential: String, callback: @escaping (String, String?) -> Void) {
        
        let config = URLSessionConfiguration.default
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config)
        
        // let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        let task = session.dataTask(with: request, completionHandler: {
                (data, response, error) -> Void in
                if (error != nil) {
                    callback("Error", error!.localizedDescription)
                } else {
                    callback(NSString(data: data!,
                        encoding: String.Encoding.utf8)! as String, nil)
                }
        }) 
        
        task.resume()
    }

    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func debugEntries(_ entries : [String : [String : String]]) {
        let reqNSData:Data?
        do {
            try reqNSData = JSONSerialization.data(withJSONObject: entries, options: JSONSerialization.WritingOptions.prettyPrinted)
            let string2 = NSString(data: reqNSData!, encoding: String.Encoding.utf8.rawValue)
            print(string2)  // Optional
            print(string2!) // Unwrapped
        }
        catch _ {
            print("ERROR")
        }
    }
    
    /*  ----------------------------------------------------------------------------------
     
     
     
        ----------------------------------------------------------------------------------
     */
    func saveEntries(_ entries : Str2Dict2Dict) {

         let reqNSData:Data?
         do {
            try reqNSData = JSONSerialization.data(withJSONObject: entries, options: JSONSerialization.WritingOptions.prettyPrinted)
   
            // Debug printout
            /* let string2 = NSString(data: reqNSData!, encoding: NSUTF8StringEncoding)
            print(string2)  // Optional
            print(string2!) // Unwrapped */
            
            HTTPPostJSON("http://valbo.dnsalias.com:9999/api/v1/add_pos", user: "fshsweden@hotmail.com", password:"wowu812", data: reqNSData!) {
                (response, error) -> Void in
                if error != nil{
                    print("Error returned was: \(response) \(error)");
                    return;
                }
                print("Response was: \(response)");
            }
          }
          catch _ {
            print("EXCEPTION on HTTPPostJSON")
         }
        
    }

    /*
    func testIt() {
        //use
        var mydata :Dictionary<String, AnyObject> = [
            "name" : "KARL KNUTSON",
            "lat" : "8953249864239",
            "lng" : "987623490623409"
        ]
        
        let wrapper : Dictionary<String, AnyObject> = [
            "player" : mydata
        ]

        // let requestNSData:NSData = NSJSONSerialization.dataWithJSONObject(data, options:NSJSONWritingOptions(rawValue: 0))
        let reqNSData:NSData?
        
        do {
            
            try reqNSData = NSJSONSerialization.dataWithJSONObject(wrapper, options: NSJSONWritingOptions.PrettyPrinted)
            
            let string2 = NSString(data: reqNSData!, encoding: NSUTF8StringEncoding)
            print(string2)  // Optional
            print(string2!) // Unwrapped
            
            HTTPPostJSON("http://valbo.dnsalias.com:9999/api/create_player", data: reqNSData!) {
                
                (response, error) -> Void in
                
                if error != nil{
                    //error
                    return;
                }
                
                print(response);
            }
        }
        catch _ {
            reqNSData = nil
        }

    }
    */
    
    

}
