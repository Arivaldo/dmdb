//
//  UIImageView.swift
//  moviedb
//
//  Created by Arivaldo Freitas on 12/05/17.
//  Copyright © 2017 Arivaldo Freitas. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func carregaImagem(url:String) {
        
        let task = URLSession.shared.dataTask(with: URL(string:url)!) { (data, response, error) -> Void in
            
            if let e = error {
                print(e)
            }else {
                
                if let res = response as? HTTPURLResponse {
                    print("Url da imagem teve Resposta \(res.statusCode)")
                    if let d = data {
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.image = UIImage(data: d)
                        })
                        
                    }else {
                        print("Não conseguiu pegar a imagem mesmo com resposta 200")
                    }
                    
                } else {
                    print("Por algum motivo não obteve resposta")
                }
                
            }
        }
        task.resume()
        
        
    }
}
