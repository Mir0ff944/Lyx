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
    public var performerName: String?
    public var performerBio: String?
    public var venue: String?
}

public struct Artist {
    public var title: String
    public var genre: String
    public var id: String
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
    var Performer: [Artist]
    
    public init() {
        Favorite = []
        Performer = []
    }
    
    /// number of events stored into the structure
    public var count: Int {
        get {
            return self.Favorite.count
        }
    }
    
    public func searchPerformer( _ completion: @escaping (Artist)->()) throws {
        let json = "https://lyx-api.herokuapp.com/performer?p=Hardwell"
        print(json)
        let session = URLSession.shared
        guard let performerURL = NSURL(string: json) else {
            throw JSONError.InvalidURL(json)
        }
        session.dataTask(with: performerURL as URL, completionHandler: {(data, response, error) -> Void in
            do{
                let json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
//                print (json)
                guard let jsondata = json["performers"] as! [[String: Any]]? else {
                    throw JSONError.InvalidKey("Invalid event")
                }
                print(jsondata)
                for result in jsondata {
                    let title = result["title"] as? String!
                    print(title!)
                    let genre = result["music_genre"] as? String!
                    print(genre!)
                    let id = result["id"] as? String!
                    print(id!)
                    let performer = Artist(title: title!, genre: genre!, id:id!)
                    completion(performer)
                }

                
            } catch {
                print("error thrown: \(error)")
            }
        }).resume()
    }
    
    public func getPerformer(forIndex index: Int) -> Artist {
        return Performer[index]
    }
    
    
    
    /// API call, laoding events into the table view
    ///
    /// - Parameters:
    ///   - text: search querey
    ///   - completion: results of search
    /// - Throws: throws missing parameters
    
    public func searchEvent(withText text:String, _ completion: @escaping ()->()) throws {
        let json = "https://lyx-api.herokuapp.com/events?l=\(text)"
        print(json)
        let session = URLSession.shared
        guard let eventURL = NSURL(string: json) else {
            throw JSONError.InvalidURL(json)
        }
        session.dataTask(with: eventURL as URL, completionHandler: {(data, response, error) -> Void in
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
                    guard let address = result["venue_address"] as? String? else {
                        throw JSONError.InvalidKey("Invalid address")
                    }
                    guard let city = result["city_name"] as? String? else {
                        throw JSONError.InvalidKey("Invalid city")
                    }
                    guard let url = result["url"] as? String? else {
                        throw JSONError.InvalidKey("Invalid url")
                    }
                    guard let country = result["country_abbr2"] as? String? else {
                        throw JSONError.InvalidKey("Invalid country")
                    }
                    guard let description = result["description"] as? String? else {
                        throw JSONError.InvalidKey("Invalid description")
                    }
                    guard let start = result["start_time"] as? String? else {
                        throw JSONError.InvalidKey("Invalid start time")
                    }
                    let eventsimage = result["image"] as? [String: Any]
                    let imageMedium = eventsimage?["medium"] as? [String: Any]
                    guard let image = imageMedium?["url"] as? String? else {
                        throw JSONError.InvalidKey("Invalid image")
                    }
                    let performers = result["performers"] as? [String: Any]
                    let performer = performers?["performer"] as? [String: Any]
                    guard let performerName = performer?["name"] as? String? else {
                        throw JSONError.InvalidKey("Invalid performer name")
                    }
                    guard let performerBio = performer?["short_bio"] as? String? else {
                        throw JSONError.InvalidKey("Invalid performer bio")
                    }
                    guard let venue = result["venue_name"] as? String? else {
                        throw JSONError.InvalidKey("Invalid venue name")
                    }
                    self.Favorite.append(Event(title: title,  city: city,address: address, url: url, country: country, description: description,start: start,  image: image, performerName: performerName, performerBio: performerBio, venue: venue))
                }
            } catch {
                print("error thrown: \(error)")
            }
            completion()
        }).resume()
    }
    
    public func getEvent(forIndex index: Int) -> Event {
        return Favorite[index]
    }
    
}
