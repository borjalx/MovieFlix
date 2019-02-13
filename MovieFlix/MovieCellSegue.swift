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
    
    var imgM: UIImage = UIImage()
    var lblTitle: String = ""
    var lblGenre: String = "Genre: "
    var lblYear: String = "Year: "
    var lblStudio: String = "Studio: "
    var lblRTS: String = "Rotten Tomatoes Score: "
    var lblAS: String = "Audience Score: "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieImg.image = imgM
        movieTitle.text = lblTitle
        movieGenre.text = lblGenre
        movieYear.text = lblYear
        movieStudio.text = lblStudio
        movieRTS.text = lblRTS
        movieAS.text = lblAS
    }
    


}
