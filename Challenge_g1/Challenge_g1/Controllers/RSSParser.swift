//
//  XMLParser.swift
//  Challenge_g1
//
//  Created by Felipe Almeida on 02/08/22.
//

import Foundation

// criando variaveis a ser utilizada atraves do RSS
class RSSParser: NSObject, XMLParserDelegate {
    var xmlParser: XMLParser! //objeto analisador real que executará todo o trabalho
    var currentElement = "" //guarda o valor da tag XML atual
    var foundCharacters = "" //representa o valor dessa tag
    var currentData = [String : String]()
    var parserData = [[String : String]]()
    var isHeader = true
    var listNews: [News] = []
    
    var list: [String] = [
        "title",
        "link",
        "description",
        "category",
        "pubDate"
    ]
    
    func startParseByUrl(rssUrl: URL, completion: ([News]) ->()) {
        
        let parser = XMLParser(contentsOf: rssUrl)
        parser?.delegate = self
        if let _ = parser?.parse() {
            
            var item = News()
            item.image = currentData["media:content"]
            item.title = currentData["title"]
            item.description = currentData["description"]
            
            listNews.append(item)
            completion(listNews)
        }
    }
    
    
    //metodos presentes no delegate : XMLParserDelegate
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if currentElement == "item" {
            
            if !isHeader {
                var item = News()
                item.image = currentData["media:content"]
                item.title = currentData["title"]
                item.description = currentData["description"]
                listNews.append(item)
            }
            
            isHeader = false
        }
        
        if isHeader == false {
            
            if currentElement == "media:content" {
                if let media = attributeDict["url"] {
                    foundCharacters += media
                }
            }
        }
    }
    // funcao para tirar espaco de string
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !isHeader {
            if list.contains(currentElement) {
                foundCharacters += string
            }
        }
    }
    // did end element -> ao finalizar o parse, vamos na String quebrando ela e setando para dentro do current data a key. current element e valor found characteres
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if !foundCharacters.isEmpty {
            foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            currentData[currentElement] = foundCharacters
            foundCharacters = ""
        }
    }
}
