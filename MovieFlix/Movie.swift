
import Foundation
import UIKit

class Movie:CustomStringConvertible{
    
    var name:String
    var genre:String
    var studio:String
    var audienceScore:String
    var rottenTomatoesScore:String
    var year:String
    var image:String
    var watched: Bool
    
    init(name:String, genre:String, studio:String, audienceScore:String, rottenTomatoesScore:String, year:String, image:String) {
        self.name = name
        self.genre = genre
        self.studio = studio
        self.audienceScore = audienceScore
        self.rottenTomatoesScore = rottenTomatoesScore
        self.year = year
        self.image = image
        self.watched = false;
    }
    
    public var description:String {
        return "Movie -> name : \(name) | genre : \(genre) | year : \(year) | url : \(image)  | watched : \(watched) "
    }
    
}
