//
//  CustomTabBar.swift
//  MovieFlix
//
//  Created by Borja S on 05/02/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    var imagenes: [UIImage] = [
        UIImage(named: "home_white")!,UIImage(named: "buscar_white")!,UIImage(named: "user_white")!,UIImage(named: "about_white")!
    ]
    var imagenesSel: [UIImage] = [UIImage(named: "home_grey")!,UIImage(named: "buscar_grey")!,UIImage(named: "user_grey")!,UIImage(named: "about_grey")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //El tabBar será de color negro
        tabBar.barTintColor = UIColor.black
        var n = 0
        for _ in imagenes {
            //obtenemos el item del tabbar
            tabBarItem = self.tabBar.items![n]
            //le establecemos la imágen normal
            tabBarItem.image = imagenes[n].withRenderingMode(.alwaysOriginal)
            //le establecemos la imágen para cuando esté seleccionada
            tabBarItem.selectedImage = imagenesSel[n].withRenderingMode(.alwaysOriginal)
            n = n+1
            //le quitamos el texto
            tabBarItem.title = ""
            //posicionamos los iconos más abajo
            tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
            
        }
    }
    

}
