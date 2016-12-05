//
//  Eventim.swift
//  Events
//
//  Created by Miroslav Ivanov on 03/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import Foundation

public  struct Event {
    public var title: String
    public var region: String
    public var city: String
}

//public struct Events {
//    public var city_name: String
//    public var title: String
//    public var image: String
//    public var venue: String
//    public var start_time: String
//}

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
    
    public func getFavorites(atIndex index: Int ) throws -> Event{
        return self.Favorite[index]
    }
    
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
                    throw JSONError.InvalidKey("items")
                }
                self.Favorite = []
                for result in jsondata{
                    print(result)
                    guard let title = result["title"] as! String? else {
                        throw JSONError.InvalidKey("Invalid Key")
                    }
                    print(title)
                    guard let region = result["region_name"] as! String? else {
                        throw JSONError.InvalidKey("Invalid Key")
                    }
                    print(region)
                    guard let city = result["city_name"] as! String? else {
                        throw JSONError.InvalidKey("Invalid Key")
                    }
                    print(city)
                    self.Favorite.append(Event(title: title, region: region, city: city))
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
    
//    public func  getDetails(withID id:String, _ completion: @escaping (Events)->()) throws {
//        completion(Events(city_name: "London", title: "Ari in London", image: "random url", venue: "O2 London", start_time: "20:00"))
//    }
}
