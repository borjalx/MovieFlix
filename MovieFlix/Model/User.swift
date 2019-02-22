//
//  User.swift
//  MovieFlix
//
//  Created by Borja S on 19/02/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import Foundation

class User{
    var name:String
    var username:String
    var about:String
    var picture:String
    var watchedMvs:[Movie]
    
    init(name:String, username:String, about:String, picture: String, watchedMvs:[Movie]) {
        self.name = name
        self.username = username
        self.about = about
        self.picture = picture
        self.watchedMvs = watchedMvs
    }
    
    public var description:String {
        return "User -> name : \(name) | username : \(username) | about : \(about) | watched movies: \(watchedMvs)"
    }
}
