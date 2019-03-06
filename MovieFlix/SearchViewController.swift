//
//  SearchViewController.swift
//  MovieFlix
//
//  Created by Borja S on 01/03/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //array con las películas filtradas
    var filteredMovies = [Movie]()
    //Objeto tableView
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
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
        //delegamos el searchBar
        searchBar.delegate = self
        //placeholder del searchbar
        searchBar.placeholder = "¿Qué película quieres?"
        /*self.creatingSearhBar()
        self.tableSettings()*/
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //dependiendo de si el usuario está buscando
        //mostramos un array u otro
        if !isSearching {
            return movies.count
        }
        else {
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
        if !isSearching {
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        //Opcion 4
        /*Filtramos haciendo minúsculas los títulos para no tener problemas con las mayúsculas*/
        //Paso 3 - Añadimos a la lista de pelis filtradas las encontradas
        filteredMovies = movies.filter({ (movie) -> Bool in
            return movie.name.lowercased().contains(searchText.lowercased())
        })
        
        //Paso 4 - Booleano que controla si esta buscando o no
        isSearching = searchText != "" ? true : false
        
        //Recargo la tabla para actualizar toda la información con el array que toque
        tableView.reloadData()
    }
    
    //Al hacer click en la Movie nos lleva a una página con su información
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mcs = storyboard!.instantiateViewController(withIdentifier: "detalleMovie") as! MovieCellSegue
        
        //Array auxiliar para almacenar el array dependiendo de si el usuario está buscando o no
        var auxarray = [Movie]()
        if !isSearching {
            auxarray = movies
        }else{
            auxarray = filteredMovies
        }
        
        //imprimimos el nombre
        print(auxarray[indexPath.row].name)
        
        //asginamos la información de la peli a una Movie auxiliar
        mcs.peli = auxarray[indexPath.row]
        //asignamos imágen de vista/no vista
        if auxarray[indexPath.row].userWatched(user: mainUser) != -1 {
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
    
    //SwipeAction en cada celda del tableView
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isWatched = watchedCategory(indexPath:indexPath)
        
        //Adjuntamos todas las opciones que necesitemos en modo de array
        return UISwipeActionsConfiguration(actions: [isWatched])
    }
    
    
    func watchedCategory(indexPath:IndexPath) -> UIContextualAction{
        
        var isWatched:Bool = false
        //defino la acción que voy a devolver en el método para el array de acciones
        let action = UIContextualAction(style: .normal, title: "", handler: {
            (action, view, completionHandler) in
            
            //FUNCIONALIDAD AQUI DENTRO
            
            //Utilizando el view le cambies el background
            var auxarray = [Movie]()
            if !self.isSearching {
                auxarray = movies
            }else{
                auxarray = self.filteredMovies
            }
            
            //SIEMPRE NIEGO LO ANTERIOR
            let peli = auxarray[indexPath.row]
            let n = peli.userWatched(user: mainUser)
            
            if  n != -1 {
                print("n = \(n)")
                mainUser.watchedMvs.remove(at: n)
                print("película retirada de las vistas")
                isWatched = false
                
            }else{
                
                mainUser.watchedMvs.append(peli)
                print("película añadida a las vistas")
                isWatched = true
            }
            print("is watched = \(isWatched)")
            //RECARGAMOS LA INFO DE LA ROW
            self.tableView.reloadRows(at: [indexPath], with: .none)
            /*RECARGAR LA INFORMACION SOLO SI CAMBIA*/
            //self.tableView.reloadData()
            
            completionHandler(true)
            
        })
        
        //ESTABLEZCO EL TITULO PARA LOS DOS CASOS
        //action.title = listaRopa[indexPath.row].isLiked ? "UnHappy!" : "Happy"
        //action.image = isWatched ? UIImage(named: "vista") : UIImage(named: "noVista")
        action.backgroundColor =  isWatched ? UIColor.red : UIColor.purple
        if isWatched {
            action.backgroundColor = UIColor.red
        }else{
            action.backgroundColor = UIColor.purple
        }
        
        //finalmente una vez configurada la acción la retorno
        return action
    }
    
}
