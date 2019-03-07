//
//  ViewController.swift
//  MovieFlix
//
//  Created by Borja S on 30/01/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

//Tools
//obtenemos las tools
var tools:Tools = Tools()
//Array de películas
var movies:[Movie] = [Movie]()
//Usuario auxiliar
var mainUser:User = User(name: "Borch", username:"leBorch1", about: "En verdad me llamo Borja, pero Borch me parecía mas cool", picture: "genio", watchedMvs: [])

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
        
        
        //Obtenemos la imagen - por ahora mostramos una general
        
         tools.getImage(imagenURL: movies[indexPath.row].image) { (imgRecovered) -> Void in
         if let imagen = imgRecovered {
         DispatchQueue.main.async {
         celda.ivImagen.image = imagen
         return
         }
         }
         }
        
        //Obtenemos la putnuacion de RT
        celda.lblRTS.text = movies[indexPath.row].rottenTomatoesScore
        //Obtenemos la puntuación de la audiencia
        celda.lblAS.text = movies[indexPath.row].audienceScore
        //Obtenemos el título
        celda.lblTitulo.text = movies[indexPath.row].name
        
        //Añadimos el icono dependiendo de si ha visto la peli
        if movies[indexPath.row].userWatched(user: mainUser) == -1 {
            celda.btnWtchd.setImage(UIImage(named: "noVista")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            celda.btnWtchd.setImage(UIImage(named: "vista")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        //Añadimos como tag del botón el nº de fila
        celda.btnWtchd.tag = indexPath.row
        //Añadimos el evento click de visto/no visto
        celda.btnWtchd.addTarget(self, action: #selector(clickWatched), for: .touchUpInside)
        
        
        return celda
    }
    
    //Función asociada al clik de vista/no vista
    @objc func clickWatched(sender: UIButton){
        let n = movies[sender.tag].userWatched(user: mainUser)
        if n == -1 {
            mainUser.watchedMvs.append(movies[sender.tag])
            sender.setImage(UIImage(named: "vista")?.withRenderingMode(.alwaysOriginal), for: .normal)
            print("Película \(movies[sender.tag].name) vista")
        }else{
            mainUser.watchedMvs.remove(at: n)
            sender.setImage(UIImage(named: "noVista")?.withRenderingMode(.alwaysOriginal), for: .normal)
            print("Película \(movies[sender.tag].name) NO vista")
        }
        
    }
    
    
    //altura del cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    //obtenemos las tools
    //var tools:Tools = Tools()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //modificamos el color de fondo del navigationController
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //obtenemos la información del csv
        tools.parseCSVMovie(movies: &movies)
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
        
        //asginamos la información de la peli a una Movie auxiliar
        mcs.peli = movies[indexPath.row]
        //asignamos imágen de vista/no vista
        if movies[indexPath.row].userWatched(user: mainUser) != -1 {
            mcs.imgW = UIImage(named: "vista")!
        }else{
            mcs.imgW = UIImage(named: "noVista")!
        }
        
        //texto especial para el botón de volver
        let backItem = UIBarButtonItem()
        backItem.title = "Go back"
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController?.pushViewController(mcs, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }


}

