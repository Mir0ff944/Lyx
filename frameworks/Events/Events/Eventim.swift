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
    case InvalidKEy(String)
    case InvalidArray
    case InvalidData
    case InvalidImage
    case indexOutOfRange
}

public  class Eventim{
    public static var sharedInstance = Eventim()
    
    var searchData:[Favorites]
    
    public init() {
        searchData = []
    }
    
    public func getFavorites(atIndex index: Int ) throws -> Favorites{
        return Favorites(title: "Ariana Grande", genre: "Pop", id: "P0-001-000237892-2")
    }
    
    public var count: Int {
        get {
            return 0
        }
    }
    
    public func search(withText text:String, _ completion: @escaping ( )->()) throws {
        completion()
    }
    
    public func  getDetails(withID id:String, _ completion: @escaping (Events)->()) throws {
        completion(Events(city_name: "London", title: "Ari in London", image: "random url", venue: "O2 London", start_time: "20:00"))
    }
}
