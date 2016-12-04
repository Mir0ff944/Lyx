//
//  Eventim.swift
//  Events
//
//  Created by Miroslav Ivanov on 03/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import Foundation

public  struct Favorites {
    public var title: String
    public var genre: String
    public var image: String
    public var id: String
}

public struct Events {
    public var city_name: String
    public var title: String
    public var image: String
    public var venue: String
    public var start_time: String
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
    
    var Favorite: [Favorites]
    
    public init() {
        Favorite = []
    }
    
    public func getFavorites(atIndex index: Int ) throws -> Favorites{
        return self.Favorite[index]
    }
    
    public var count: Int {
        get {
            return self.Favorite.count
        }
    }
    
    public func search(withText text:String, _ completion: @escaping ()->()) throws {
        let json = "https://lyx-api.herokuapp.com/performer?p=\(text)"
        print(json)
        let session = URLSession.shared
        guard let performerURL = NSURL(string: json) else {
            throw JSONError.InvalidURL(json)
        }
        session.dataTask(with: performerURL as URL, completionHandler: {(data, response, error) -> Void in
            do{
                let json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                print(json)
                guard let jsondata = json["performers"] as! [[String: Any]]? else {
                    throw JSONError.InvalidKey("items")
                }
                self.Favorite = []
                for result in jsondata{
                    print(result)
                    guard let title = result["title"] as! String? else {
                        throw JSONError.InvalidKey("Invalid Key")
                    }
                    print(title)
                    guard let genre = result["music_genre"] as! String? else {
                        throw JSONError.InvalidKey("Invalid Key")
                    }
                    print(genre)
                    guard let image = result["image"] as! String? else {
                        throw JSONError.InvalidKey("Invalid Key")
                    }
                    print(image)
                    guard let id = result["id"] as! String? else {
                        throw JSONError.InvalidKey("Invalid Key")
                    }
                    print(id)
                    self.Favorite.append(Favorites(title: title, genre: genre, image: image, id: id))
                }
            } catch {
                print("erro thrown: \(error)")
            }
            completion()
        }).resume()
    }
    
    public func  getDetails(withID id:String, _ completion: @escaping (Events)->()) throws {
        completion(Events(city_name: "London", title: "Ari in London", image: "random url", venue: "O2 London", start_time: "20:00"))
    }
}
