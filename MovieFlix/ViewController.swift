//
//  ViewController.swift
//  MovieFlix
//
//  Created by Borja S on 30/01/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Array de películas
    var movies:[Movie] = [Movie]()
    //obtenemos las tools
    var tools:Tools = Tools()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tools.parseCSVMovie(movies: &movies)
        
        printMovies()
    }
    
    func printMovies() {
        for movie in movies {
            print(movie)
        }
    }


}

