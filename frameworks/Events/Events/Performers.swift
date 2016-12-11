//
//  Performers.swift
//  Events
//
//  Created by Miroslav Ivanov on 11/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import Foundation

public struct Performers {
    public var name: String
}


public  class Performer{
    public static var sharedInstance = Performer()
    
    public var favorites: [Performers]
    
    public init() {
        favorites = []
    }
    
    public var count: Int {
        get {
            return self.favorites.count
        }
    }
    
    public func insert(fav: Performers) {
        self.favorites.append(fav)
    }
    
    
    public func saveList() {
        let saved = UserDefaults.standard
        saved.set(favorites, forKey: "favorites")
        saved.synchronize()
        print(favorites)
        print("data laoded")
    }
    
    public func getPerformer(forIndex index: Int) -> Performers {
        return favorites[index]
    }
}
