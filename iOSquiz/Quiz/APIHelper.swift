//
//  APIHelper.swift
//  Quiz
//
//  Created by Aziza Kamet on 09.10.17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class APIHelper: NSObject {
    
    func httpGet(request: NSURLRequest!, callback: @escaping (NSString, NSString?) -> Void)
    {
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error?.localizedDescription as NSString?)
            } else {
                let result = NSString(data: data!, encoding:
                    String.Encoding.ascii.rawValue)!
                callback(result, nil)
            }
        }
        task.resume()
    }
    func makeRequest(callback: @escaping (NSString) ->Void) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonblob.com/api/ab269aeb-affd-11e7-b7f1-413c73058dea")! as URL)
        request.httpMethod = "GET"
        
        var result:NSString = ""
        
        
        httpGet(request: request){
            (data, error) ->  Void in
            
            if error != nil {
                result = error!
            } else {
                result = data
            }
            
            callback(data)
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension NSObject{
    convenience init(jsonString:String) {
        self.init()
        
        if let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                
                // Loop
                for (key, value) in json {
                    let keyName = key as String
                    let keyValue: String = value as! String
                    
                    // If property exists
                    if (self.responds(to: (NSSelectorFromString(keyName)))) {
                        self.setValue(keyValue, forKey: keyName)
                    }
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        else
        {
            print("json is of wrong format!")
        }
    }
}
