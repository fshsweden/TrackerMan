//
//  RestApiManager.swift
//  SimpleGPSTest
//
//  Created by Peter Andersson on 02/08/16.
//  Copyright © 2016 Peter Andersson. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

public enum RestError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

class RestApiClient: NSObject {
    static let sharedInstance = RestApiClient()

    
    
    // let baseURL = "http://api.randomuser.me/"
    let baseURL = "http://valbo.dnsalias.com:9999/get_users"
    let getTreasuresURL = "http://valbo.dnsalias.com:9999/get_treasures_within"
    
    func getRandomUser(onCompletion: (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }

    func getTreasures(
        lat: Double,
        lng: Double,
        maxdist : Double,
        onCompletion: (JSON) -> Void) {
        let route = getTreasuresURL + "?lat=\(lat);lng=\(lng);maxdist=\(maxdist)";
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
    
    
    func HTTPPostJSON(url: String,  data: NSData, callback: (String, String?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        request.HTTPBody = data
        HTTPsendRequest(request, callback: callback)
    }
    
    func HTTPsendRequest(request: NSMutableURLRequest, callback: (String, String?) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
                (data, response, error) -> Void in
            
                if (error != nil) {
                    callback("Error", error!.localizedDescription)
                } else {
                    callback(NSString(data: data!,
                        encoding: NSUTF8StringEncoding)! as String, nil)
                }
        }
        
        task.resume()
    }

    
    func debugEntries(entries : [String : [String : String]]) {
        let reqNSData:NSData?
        do {
            try reqNSData = NSJSONSerialization.dataWithJSONObject(entries, options: NSJSONWritingOptions.PrettyPrinted)
            let string2 = NSString(data: reqNSData!, encoding: NSUTF8StringEncoding)
            print(string2)  // Optional
            print(string2!) // Unwrapped
        }
        catch _ {
            print("ERROR")
        }
    }
    
    
    func saveEntries(entries : Str2Dict2Dict) {

         let reqNSData:NSData?
         do {
            try reqNSData = NSJSONSerialization.dataWithJSONObject(entries, options: NSJSONWritingOptions.PrettyPrinted)
   
            // Debug printout
            /* let string2 = NSString(data: reqNSData!, encoding: NSUTF8StringEncoding)
            print(string2)  // Optional
            print(string2!) // Unwrapped */
            
            HTTPPostJSON("http://valbo.dnsalias.com:9999/api/add_pos", data: reqNSData!) {
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
