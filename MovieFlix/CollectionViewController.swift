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
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //número de items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("likedmovies count : \(likedMovies.count)")
        return likedMovies.count
        
    }
    
    //efecto de fade in
    
    //celdas del collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvitem", for: indexPath) as! MovieCollectionViewCell
        //Obtenemos la imagen - por ahora mostramos una general
        if let url = URL(string: likedMovies[indexPath.row].image){
            var url:URL = URL(string: "https://i.imgur.com/W6IUotA.jpg")!
            let data = try? Data(contentsOf: url)
            cell.ivWM.image = UIImage(data: data!)
        }
        
        //asginamos texo el label
        cell.lblWM.text = likedMovies[indexPath.row].name
        //asginamos la imagen al botón
        cell.btnWM.setImage(UIImage(named: "vista")?.withRenderingMode(.alwaysOriginal), for: .normal)
        //asginamos función de click al botón
        cell.btnWM.addTarget(self, action: #selector(clickUnwatch), for: .touchUpInside)
        
        return cell
    }
    
    //función asociada al click del botón
    @objc func clickUnwatch(sender: UIButton){
        print("Pelicula \(likedMovies[sender.tag].name) ya NO vista")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        likedMovies = movies//mainUser.watchedMvs
        //le asginamos valores a los componentes que tienen la información del user
        ivUser.image = UIImage(named: mainUser.picture)

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    


}
