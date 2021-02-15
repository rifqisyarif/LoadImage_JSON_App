//
//  NewsModel.swift
//  LoadImage JSON
//
//  Created by Rifqi on 08/02/21.
//

import Foundation
import Combine
import SwiftyJSON

class NewsModel: ObservableObject {
    @Published var data = [News]()
    
    init() {
        
        let url =
            "http://newsapi.org/v2/top-headlines?country=id&category=technology&apiKey=641604b95da8433fa33a6fc3fcdc668b"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let items = json["articles"].array!
            
            for i in items {
                
                let title = i["title"].stringValue
                let description = i["description"].stringValue
                let imurl = i["urlToImage"].stringValue
                
                DispatchQueue.main.async {
                    self.data.append(News(title: title, description:description, image: imurl))
                }
            }
        }.resume()
        
    }
    
}
