//
//  MovieCellSegue.swift
//  MovieFlix
//
//  Created by Borja S on 13/02/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

class MovieCellSegue: UIViewController {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieStudio: UILabel!
    @IBOutlet weak var movieRTS: UILabel!
    @IBOutlet weak var movieAS: UILabel!
    @IBOutlet weak var movieW: UIButton!
    
    var peli:Movie?
    
    var imgM: UIImage = UIImage()
    var imgW: UIImage = UIImage()
    var lblTitle: String = ""
    var lblGenre: String = "Genre: "
    var lblYear: String = "Year: "
    var lblStudio: String = "Studio: "
    var lblRTS: String = "Rotten Tomatoes Score: "
    var lblAS: String = "Audience Score: "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.getImage(imagenURL: (peli?.image)!) { (imgRecovered) -> Void in
            if let imagen = imgRecovered {
                DispatchQueue.main.async {
                    self.movieImg.image = imagen
                    return
                }
            }
        }
        movieTitle.text = peli?.name
        movieGenre.text = "Genre: \(peli?.genre ?? "No genre found")"
        movieYear.text = "Year: \(peli?.year ?? "No year found")"
        movieStudio.text = "Studio: \(peli?.studio ?? "No studio found")"
        movieRTS.text = "RottenTomatoes Score: \(peli?.rottenTomatoesScore ?? "No score found")"
        movieAS.text = "Audience Score: \(peli?.audienceScore ?? "No score found")"
        movieW.setImage(imgW.withRenderingMode(.alwaysOriginal), for: .normal)
        
    }
    
    @IBAction func unwatch(_ sender: UIButton) {
        let n = peli?.userWatched(user: mainUser)
        if  n != -1 {
            print("n = \(n)")
            
            mainUser.watchedMvs.remove(at: n!)
            print("película retirada de las vistas")
            imgW = UIImage(named: "noVista")!
            
        }else{
            
            mainUser.watchedMvs.append(peli!)
            print("película añadida a las vistas")
            imgW = UIImage(named: "vista")!
        }
        movieW.setImage(imgW, for: .normal)
    }
    

}
