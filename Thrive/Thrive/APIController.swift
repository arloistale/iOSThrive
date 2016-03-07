//
//  APIController.swift
//  Thrive
//
//  Created by Jonathan Lu on 3/2/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import Foundation

let apiURL = "http://Jonathans-MacBook-Pro.local:8081/"
let apiCardsPoint = "items"

class APIController {
    
    typealias APICallback = ((error: NSError?, results: [Card]?) -> Void)
    
    func searchCards(pagination: Int, completionHandler: APICallback) {
        let urlPath = apiURL.stringByAppendingString(apiCardsPoint)
        let url = NSURL(string: urlPath)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, err) in
            
            if(err != nil) {
                completionHandler(error: err! as NSError, results: nil)
            } else {
                do {
                    let responseObject = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    let responseDict = responseObject as? [String: AnyObject]
                    guard let responseArray = responseDict?["data"] as? [[String: AnyObject]] else {
                        completionHandler(error: NSError(domain: "Json Error", code: 0, userInfo: nil), results: nil)
                        return
                    }
                    
                    var cards = [Card]()
                    
                    for dataObject : [String: AnyObject] in responseArray {
                        guard let dateString = dataObject["created_at"] as? String,
                            let date = DateUtils.getDateFromString(dateString) else {
                                
                            print("Invalid card received (no date)")
                            continue
                        }
                        
                        //guard let moodIndex = dataObject["moodIndex"] as?
                        
                        let message = dataObject[Card.PropertyKey.messageKey] as? String
                        let moodIndex = 0
                        let photo = dataObject[Card.PropertyKey.photoKey] as? String
                        
                        if let card = Card(date: date, moodIndex: moodIndex, message: message, photo: photo) {
                            cards.append(card)
                        }
                    }
                    
                    completionHandler(error: nil, results: cards)
                } catch {
                    completionHandler(error: error as? NSError, results: nil)
                }
            }
        })
        
        task.resume()
    }
}