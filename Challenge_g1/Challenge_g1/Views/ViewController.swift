//
//  ViewController.swift
//  Challenge_g1
//
//  Created by Felipe Almeida on 02/08/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var listNews: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parserClass = RSSParser()
        
        // buscando informacoes da RSS atraves do link
        if let url = URL(string: "https://g1.globo.com/rss/g1/carros/") {
            parserClass.startParseByUrl(rssUrl: url) { result in
                self.listNews = result
                tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNews.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else {
            return UITableViewCell()
        }
        
        let news = listNews[indexPath.row]
        cell.setValues(news: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UIViewMateria") as! UIViewMateria
        controller.news = listNews[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

