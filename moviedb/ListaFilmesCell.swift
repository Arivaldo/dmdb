//
//  ListaFilmesCell.swift
//  moviedb
//
//  Created by Arivaldo Freitas on 11/05/17.
//  Copyright © 2017 Arivaldo Freitas. All rights reserved.
//

import UIKit

class ListaFilmesCell: UITableViewCell {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var media: UILabel!
    @IBOutlet weak var lancamento: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var categoria: UILabel!
    
    
    @IBAction func detalhe(_ sender: Any) {
    }
    
    func setFilme(_ filme:Filme) -> Void {
        self.titulo.text = filme.titulo
        self.media.text = "\(filme.media!)\u{2605}"
        self.lancamento.text = filme.lancamento.substring(to: filme.lancamento.index(filme.lancamento.startIndex, offsetBy: 4))
        self.descricao.text = filme.descricao
        self.categoria.text = filme.categoria
        self.imagem.carregaImagem(url: "http://image.tmdb.org/t/p/w92".appending(filme.imagem))
    }
    

    
}
