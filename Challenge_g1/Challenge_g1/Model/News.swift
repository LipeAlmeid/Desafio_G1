//
//  FeedModel.swift
//  Challenge_g1
//
//  Created by Felipe Almeida on 02/08/22.
//

import Foundation

struct News {
    var image: String?
    var title: String?
    var description: String?
    
    // funcao para realizar o donwload da imagem.
    func fetchImage(urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else { return completionHandler(nil) }
            
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
            
        dataTask.resume()
    }
}
