//
//  ViewController.swift
//  moviedb
//
//  Created by Arivaldo Freitas on 11/05/17.
//  Copyright © 2017 Arivaldo Freitas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var categorias: [Int:String] = [Int:String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=50f05b1ddfca3623343d154943873216&language=pt-BR")!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        as? [String:Any] {
                        if let dicionarioDeCategorias = json["genres"] as? [[String: Any]] {
                            for d in dicionarioDeCategorias {
                                self.categorias[d["id"]! as! Int] = d["name"] as! String
                            }
                        }
                        
                    }
                    
                } catch {
                    print(error)
                }
                
            }
        }
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paraLista" {
            let navigationController = segue.destination as! UINavigationController
            let view = navigationController.viewControllers[0] as! ListaFilmesController
            view.categorias = self.categorias
            
        }
    }


}

