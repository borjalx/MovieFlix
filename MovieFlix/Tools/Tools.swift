import Foundation
import UIKit

class Tools{
    
    func getImage(imagenURL:String, completion: @escaping (_ image: UIImage?) -> ()) {
        
        let imgURL = URL(string: imagenURL)!
        
        //Creates a default configuration object that uses the disk-persisted global cache, credential and cookie storage objects.
        //Creamos la sesion
        let session = URLSession(configuration: .default)
        
        //Obtengo la URL definiendola del tipo data, el cod de respuesta y el error
        session.dataTask(with: imgURL) { (data, response, error) in
            //Una vez descargada la imagen puedo tratarla
            //Comprobamos que no se haya producido ningun error
            if let e = error {
                print("Error downloading image: \(e)")
            } else {
                // Tratamos la respuesta de la URL
                //Comprobamos el tipo de respuesta obtenida
                if let res = response as? HTTPURLResponse {
                    print("Downloaded image with response code \(res.statusCode)") //200 : Todo OK, Jose Luís!
                    //Tratamos el data obtenido de la URL
                    if let imageData = data {
                        // Convertimos la imagen del tipo data a una UIImage para poder enviarla en el completion
                        completion(UIImage(data: imageData)!)
                    } else {
                        print("Couldn't get image: Image is nil") //No se ha podido obtener el recurso
                    }
                } else {
                    print("Couldn't get response code for some reason") //El servidor no esta accesible
                }
            }
            }.resume()
    }
    
    func parseCSVMovie(movies: inout [Movie]){
        
        //Obtenemos el fichero y el tipo
        let path = Bundle.main.path(forResource: "movies", ofType: "csv")!
        
        do{
            
            //Utilizamos la libreria para obtener la decodificacion
            let csv = try CSV(contentsOfURL: path)
            
            //Recorremos el fichero por fila y lo guardamos en el array
            for row in csv.rows {
                let movie = Movie(name: row["Film"]! != "" ? row["Film"]! : "null",
                                  genre: row["Genre"]! != "" ? row["Genre"]! : "null",
                                  studio: row["LeadStudio"]! != "" ? row["LeadStudio"]! : "null",
                                  audienceScore: row["Audiencescore"]! != "" ? row["Audiencescore"]! : "null" ,
                                  rottenTomatoesScore: row["RottenTomatoes"]! != " " ? row["RottenTomatoes"]! : "null",
                                  year: row["Year"]! != "" ? row["Year"]! : "null",
                                  image: row["Image"]! != "" ? row["Image"]! : "null")
                movies.append(movie)
            }
            
        } catch let error as NSError{
            print("ERROR decodificando el CSV -> ", error)
        }
        
    }
    
}
