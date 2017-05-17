//
//  ListaFilmesController.swift
//  moviedb
//
//  Created by Arivaldo Freitas on 11/05/17.
//  Copyright © 2017 Arivaldo Freitas. All rights reserved.
//

import UIKit
import Foundation

class ListaFilmesController : UITableViewController {
    
    var filmes: [Filme] = []
    var categorias: [Int:String] = [Int:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = URLRequest(url: URL(string: "http://api.themoviedb.org/3/movie/popular?api_key=50f05b1ddfca3623343d154943873216&query=whiplash&language=pt-BR")!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    as? [String:Any] {
                        
                        if let listaDeFilmes = json["results"] as? [[String : Any]] {
                            for mapa in listaDeFilmes {
                                let f = Filme()
                                f.id = mapa["id"] as! Int
                                f.imagem = mapa["poster_path"] as! String
                                f.lancamento = mapa["release_date"] as! String
                                f.media = mapa["vote_average"] as! Float
                                f.titulo = mapa["title"] as! String
                                f.descricao = mapa["overview"] as! String
                                if let cat = mapa["genre_ids"] as? [Int] {
                                    for (index, id) in cat.enumerated() {
                                        if index < (cat.count - 1){
                                            f.categoria = f.categoria.appending(self.categorias[id]!).appending(",")
                                        } else {
                                            f.categoria = f.categoria.appending(self.categorias[id]!)
                                        }
                                        
                                    }
                                }
                                self.filmes.append(f)
                                
                            }
                            self.tableView.reloadData()
                        }
                        
                    }
                    
                } catch {
                    print(error)
                }
                
            }
        }
        task.resume()
        
    
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filmes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filme = self.filmes[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "filmesReuso", for: indexPath) as! ListaFilmesCell
        celula.setFilme(filme)
        return celula
        
    }
    
}
