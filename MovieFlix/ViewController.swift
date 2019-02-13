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
        //printMovies()
        //delgemos el tableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Función que imprime información sobre las películas
    func printMovies() {
        for movie in movies {
            print(movie)
        }
    }
    
    //Al hacer click en la Movie nos lleva a una página con su información
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mcs = storyboard!.instantiateViewController(withIdentifier: "detalleMovie") as! MovieCellSegue
        
        //imprimimos el nombre
        print(movies[indexPath.row].name)
        
        //asiganamos los valores de tipo texto
        mcs.lblAS = mcs.lblAS + movies[indexPath.row].audienceScore
        mcs.lblRTS = mcs.lblRTS + movies[indexPath.row].rottenTomatoesScore
        mcs.lblStudio = mcs.lblStudio + movies[indexPath.row].studio
        mcs.lblYear = mcs.lblYear + movies[indexPath.row].year
        mcs.lblGenre = mcs.lblGenre + movies[indexPath.row].genre
        mcs.lblTitle = movies[indexPath.row].name
        
        //le asignamos la imagen
        if let url = URL(string: movies[indexPath.row].image){
            var url:URL = URL(string: "https://i.imgur.com/W6IUotA.jpg")!
            let data = try? Data(contentsOf: url)
            mcs.imgM = UIImage(data: data!)!
        }
        
        //texto especial para el botón de volver
        let backItem = UIBarButtonItem()
        backItem.title = "Go back"
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController?.pushViewController(mcs, animated: true)
    }


}

