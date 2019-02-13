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
