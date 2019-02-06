import Foundation

class Tools{
    
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
                                  studio: row["Lead Studio"]! != "" ? row["Lead Studio"]! : "null",
                                  audienceScore: row["Audience score %"]! != "" ? row["Audience score %"]! : "null" ,
                                  rottenTomatoesScore: row["Rotten Tomatoes %"]! != "" ? row["Rotten Tomatoes %"]! : "null",
                                  year: row["Year"]! != "" ? row["Year"]! : "null",
                                  image: "null")
                movies.append(movie)
            }
            
        } catch let error as NSError{
            print("ERROR decodificando el CSV -> ", error)
        }
        
    }
    
}
