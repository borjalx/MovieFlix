//
//  AboutViewController.swift
//  MovieFlix
//
//  Created by Borja S on 07/03/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    
    @IBOutlet weak var lblInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //cargamos la info
        addBgColor()
        addInfo()
        
    }
    
    //función que añade el color de fondo degradado
    func addBgColor(){
        // color de fondo gris oscuro
        //self.view.backgroundColor = UIColor.darkGray
        
        // Creamos los colores a pasar
        let color1 = UIColor.black
        let color2 = UIColor.darkGray
        let color3 = UIColor.lightGray

        //creamos el gradientLayer
        let gradientLayer = CAGradientLayer()
        // gradientLayer tiene de frame los límites de la view
        gradientLayer.frame = self.view.bounds
        
        

        //le asignamos los colores al gradientLayer
        gradientLayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
        
        // le asignamos las posiciones de los distintos colores
        gradientLayer.locations = [0.0, 0.4, 0.8]
        
        // añadimos el gradientLayer a la view
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    //función que añade el texto al label de la info
    func addInfo(){
        lblInfo.text = "Now, this is a story all about how my life got flipped-turned upside down and I'd like to take a minute just sit right there I'll tell you how I became the prince of a town called Bel Air"
        lblInfo.backgroundColor = UIColor.lightGray
        lblInfo.textColor = UIColor.white
    }

}
