//
//  FeedCell.swift
//  Challenge_g1
//
//  Created by Felipe Almeida on 02/08/22.
//

import UIKit

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()   
    }
    // funcao para informacoes das noticias -> titulo / imagem
    func setValues(news: News) {
        
        titleLabel.text = news.title
        
        if let stringUrl = news.image {
            news.fetchImage(urlString: stringUrl) { imageData in
                if let data = imageData {
                    DispatchQueue.main.async {
                        self.feedImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
