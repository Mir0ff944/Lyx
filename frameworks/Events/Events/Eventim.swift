//
//  Eventim.swift
//  Events
//
//  Created by Miroslav Ivanov on 03/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import Foundation

public  struct Event {
    public var title: String?
    public var city: String?
    public var address: String?
    public var url: String?
    public var country: String?
    public var description: String?
    public var start: String?
    public var image: String?
}


enum JSONError: Error{
    case InvalidURL(String)
    case InvalidKey(String)
    case InvalidArray
    case InvalidData
    case InvalidImage
    case indexOutOfRange
}

public  class Eventim{
    public static var sharedInstance = Eventim()
    
    var Favorite: [Event]
    
    public init() {
        Favorite = []
    }
    
//    public func getFavorites(atIndex index: Int ) throws -> Event{
//        return self.Favorite[index]
//    }
    
    public var count: Int {
        get {
            return self.Favorite.count
        }
    }
    
    public func search(withText text:String, _ completion: @escaping ()->()) throws {
        let json = "https://lyx-api.herokuapp.com/events?l=\(text)"
        print(json)
        let session = URLSession.shared
        guard let performerURL = NSURL(string: json) else {
            throw JSONError.InvalidURL(json)
        }
        session.dataTask(with: performerURL as URL, completionHandler: {(data, response, error) -> Void in
            do{
                let json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                print(json)
                guard let jsondata = json["event"] as! [[String: Any]]? else {
                    throw JSONError.InvalidKey("Invalid event")
                }
                self.Favorite = []
                for result in jsondata{
                   // print(result)
                    guard let title = result["title"] as? String? else {
                        throw JSONError.InvalidKey("Invalid title")
                    }
//                    print(title!)
                    guard let address = result["venue_address"] as? String? else {
                        throw JSONError.InvalidKey("Invalid address")
                    }
//                    print(address!)
                    guard let city = result["city_name"] as? String? else {
                        throw JSONError.InvalidKey("Invalid city")
                    }
//                    print(city!)
                    guard let url = result["url"] as? String? else {
                        throw JSONError.InvalidKey("Invalid url")
                    }
//                    print(url!)
                    guard let country = result["country_abbr2"] as? String? else {
                        throw JSONError.InvalidKey("Invalid country")
                    }
//                    print(country!)
                    guard let description = result["description"] as? String? else {
                        throw JSONError.InvalidKey("Invalid description")
                    }
                    guard let start = result["start_time"] as? String? else {
                        throw JSONError.InvalidKey("Invalid start time")
                    }
                    guard let eventsimage = result["image"] as? [String: Any] else {
                        throw JSONError.InvalidKey("Invalid description")
                    }
                    guard let imageMedium = eventsimage["medium"] as? [String: Any] else {
                        throw JSONError.InvalidKey("Invalid description")
                    }
                    guard let image = imageMedium["url"] as? String else {
                        throw JSONError.InvalidKey("Invalid description")
                    }
                    print(image)
                    self.Favorite.append(Event(title: title,  city: city,address: address, url: url, country: country, description: description,start: start,  image: image))
                }
            } catch {
                print("erro thrown: \(error)")
            }
            completion()
        }).resume()
    }
    
    public func getEvent(forIndex index: Int) -> Event {
        return Favorite[index]
    }
    
//    public func  getDetails(withID id:String, _ completion: @escaping (Event)->()) throws {
//        completion(Event( title: title?, region: "random url", city: "London"))
//    }
}
