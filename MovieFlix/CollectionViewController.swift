//
//  CollectionViewController.swift
//  MovieFlix
//
//  Created by Borja S on 22/02/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var likedMovies:[Movie] = []
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //número de items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return likedMovies.count
        
    }
    
    //mostrar más información de la palícula
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mcs = storyboard.instantiateViewController(withIdentifier: "detalleMovie") as! MovieCellSegue

        //asginamos la información de la peli a una Movie auxiliar
        mcs.peli = likedMovies[indexPath.row]
        //asignamos imágen de vista/no vista
        /*if movies[indexPath.row].userWatched(user: mainUser) != -1 {*/
            mcs.imgW = UIImage(named: "vista")!
        /*}else{
            mcs.imgW = UIImage(named: "noVista")!
        }*/
        //texto especial para el botón de volver
        let backItem = UIBarButtonItem()
        backItem.title = "Go back"
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController?.pushViewController(mcs, animated: true)
        
        //imprimimos el nombre
        print(likedMovies[indexPath.row].name)
    }
    
    //efecto de fade in
    
    //celdas del collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvitem", for: indexPath) as! MovieCollectionViewCell
        //Obtenemos la imagen - por ahora mostramos una general
        tools.getImage(imagenURL: likedMovies[indexPath.row].image) { (imgRecovered) -> Void in
            if let imagen = imgRecovered {
                DispatchQueue.main.async {
                    cell.ivWM.image = imagen
                    return
                }
            }
        }
        
        //asginamos texo el label
        cell.lblWM.text = likedMovies[indexPath.row].name
        //asginamos la imagen al botón
        cell.btnWM.setImage(UIImage(named: "vista")?.withRenderingMode(.alwaysOriginal), for: .normal)
        /*//asginamos función de click al botón
        cell.btnWM.addTarget(self, action: #selector(clickUnwatch), for: .touchUpInside)*/
        
        return cell
    }
    
    /*
    //función asociada al click del botón
    @objc func clickUnwatch(sender: UIButton){
        print("Pelicula \(likedMovies[sender.tag].name) ya NO vista")
    }*/
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //modificamos el color de fondo del navigationController
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        //likedMovies = mainUser.watchedMvs
        //print("likedMovies = all movies")
        print("likedMovies count = \(likedMovies.count)")
        //le asginamos valores a los componentes que tienen la información del user
        ivUser.image = UIImage(named: mainUser.picture)
        //ImageView de la imágen del usuario con bordes redondos
        ivUser.layer.borderWidth = 1
        ivUser.layer.masksToBounds = false
        ivUser.layer.borderColor = UIColor.black.cgColor
        ivUser.layer.cornerRadius = ivUser.frame.height/2
        ivUser.clipsToBounds = true
        //información del user
        lblName.text = mainUser.name
        lblUsername.text = mainUser.username
        lblDescription.text = mainUser.about

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        likedMovies = mainUser.watchedMvs
        
        collectionView.reloadData()
        
    }
    


}
