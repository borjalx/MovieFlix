//
//  SearchViewController.swift
//  MovieFlix
//
//  Created by Borja S on 01/03/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //array con las películas filtradas
    var filteredMovies = [Movie]()
    //Objeto tableView
    @IBOutlet weak var tableView: UITableView!
    //encargado de gestionar la TableView en la que mostraremos los resultados de las búsquedas
    var resultsController = UITableViewController()
    //gestiona el funcionamiento de la UISearchBar
    var searchController : UISearchController!
    
    //el usuario está buscando?
    var isSearching:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //modificamos el color de fondo del navigationController
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white

        //delegamos el tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        self.creatingSearhBar()
        self.tableSettings()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //si le llama el tableView mostramos todas las movies
        print(movies.count)
        print(movies[0].name)
        //return movies.count
        if tableView == self.tableView {
            return movies.count
        }
        else {
            //si le llama el tableview de resultados
            return filteredMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellMovies
        //BORRAR - celda.lblTitulo.text = movies[indexPath.row].name
        
        
        var auxarray = [Movie]()
        if tableView == self.tableView {
            auxarray = movies
        }else{
            auxarray = filteredMovies
        }
        //Obtenemos la imagen - por ahora mostramos una general
        
        tools.getImage(imagenURL: auxarray[indexPath.row].image) { (imgRecovered) -> Void in
            if let imagen = imgRecovered {
                DispatchQueue.main.async {
                    celda.ivImagen.image = imagen
                    return
                }
            }
        }
        
        //Obtenemos el título
        celda.lblTitulo.text = auxarray[indexPath.row].name
        print("auxarray[indexPath.row].name : \(auxarray[indexPath.row].name)")
        //Obtenemos la putnuacion de RT
        celda.lblRTS.text = auxarray[indexPath.row].rottenTomatoesScore
        //Obtenemos la puntuación de la audiencia
        celda.lblAS.text = auxarray[indexPath.row].audienceScore
        
        
        //Añadimos el icono dependiendo de si ha visto la peli
        /*if auxarray[indexPath.row].userWatched(user: mainUser) == -1 {
            celda.btnWtchd.setImage(UIImage(named: "noVista")?.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else {
            celda.btnWtchd.setImage(UIImage(named: "vista")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }*/
        /*
        //Añadimos como tag del botón el nº de fila
        celda.btnWtchd.tag = indexPath.row
        //Añadimos el evento click de visto/no visto
        celda.btnWtchd.addTarget(self, action: #selector(clickWatched), for: .touchUpInside)
         */
        
        
        return celda
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
    
    //Función que crea el searchbar
    func creatingSearhBar() {
        //lo creamos a partir del resultsController
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        //aparecerá en la parte superior de la view
        self.tableView.tableHeaderView = self.searchController.searchBar
        //nuestro SearchViewController será quien lo adopte
        self.searchController.searchResultsUpdater = self
    }
    
    //Función que delega el nuevo tableview
    func tableSettings() {
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredMovies = movies.filter { (movie: Movie) -> Bool in
            if movie.name.lowercased().contains(self.searchController.searchBar.text!.lowercased()){
                return true
            } else{
                return false
            }
        }
        
        self.resultsController.tableView.reloadData()
    }
    
}
