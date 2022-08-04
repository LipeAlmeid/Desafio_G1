//
//  UIViewMateria.swift
//  Challenge_g1
//
//  Created by Felipe Almeida on 02/08/22.
//

import UIKit

class UIViewMateria: UIViewController {
//    @IBOutlet weak var newsImageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        titleLabel.text = news?.title
        descriptionLabel.text = news?.description
        
        if let imageSring = news?.image {
            news?.fetchImage(urlString: imageSring, completionHandler: { imageData in
                
                if let data = imageData {
                    DispatchQueue.main.async {
                        self.newsImageView.image = UIImage(data: data)
                    }
                }
            })
        }
    }
    
}
