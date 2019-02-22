
import Foundation
import UIKit

class Movie:CustomStringConvertible, Equatable{
    
    
    
    var name:String
    var genre:String
    var studio:String
    var audienceScore:String
    var rottenTomatoesScore:String
    var year:String
    var image:String
    /*ELIMINAR - var watched: Bool*/
    
    init(name:String, genre:String, studio:String, audienceScore:String, rottenTomatoesScore:String, year:String, image:String) {
        self.name = name
        self.genre = genre
        self.studio = studio
        self.audienceScore = audienceScore
        self.rottenTomatoesScore = rottenTomatoesScore
        self.year = year
        self.image = image
        /*ELIMINAR - self.watched = false;*/
    }
    
    public var description:String {
        return "Movie -> name : \(name) | genre : \(genre) | year : \(year) | url : \(image)"  /*| watched : \(self.userWatched(user: mainUser)) "*/
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.name == rhs.name /*&&
        lhs.genre == rhs.genre &&
        lhs.studio == rhs.studio &&
        lhs.audienceScore == rhs.audienceScore &&
        lhs.rottenTomatoesScore == rhs.rottenTomatoesScore &&
        lhs.year == rhs.year &&
        lhs.image == rhs.image*/
    }
    
    func userWatched(user: User) -> (Bool){
        var liked = false
        for movie in user.watchedMvs {
            if(movie == self){
                liked = true
            }
        }
        
        return liked
    }
    
}
