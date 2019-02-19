//
//  CustomCellMovies.swift
//  MovieFlix
//
//  Created by Borja S on 13/02/2019.
//  Copyright © 2019 Borja S. All rights reserved.
//

import UIKit

class CustomCellMovies: UITableViewCell {

    @IBOutlet weak var ivImagen: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAS: UILabel!
    @IBOutlet weak var lblRTS: UILabel!
    @IBOutlet weak var btnWtchd: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
