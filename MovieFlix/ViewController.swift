//
//  ViewController.swift
//  MovieFlix
//
//  Created by Borja S on 30/01/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

var movies:[Movie] = [Movie]()

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //número de rows que habrán
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //efecto de fade in
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        
        UIView.animate(withDuration: 1.0){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CustomCellMovies
        
        
        //Obtenemos la imagen
        if let url = URL(string: movies[indexPath.row].image){
            var url:URL = URL(string: "https://i.imgur.com/W6IUotA.jpg")!
            let data = try? Data(contentsOf: url)
        celda.ivImagen.image = UIImage(data: data!)
        }
        
        //Obtenemos la putnuacion de RT
        celda.lblRTS.text = movies[indexPath.row].rottenTomatoesScore
        //Obtenemos la puntuación de la audiencia
        celda.lblAS.text = movies[indexPath.row].audienceScore
        //Obtenemos el título
        celda.lblTitulo.text = movies[indexPath.row].name
        
        return celda
    }
    
    //altura del cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

    @IBOutlet weak var tableView: UITableView!
    //Array de películas
    
    //obtenemos las tools
    var tools:Tools = Tools()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //obtenemos la información del csv
        tools.parseCSVMovie(movies: &movies)
        //imptimimos la información de las peliculas por consola
        printMovies()
        //delgemos el tableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func printMovies() {
        for movie in movies {
            print(movie)
        }
    }


}

