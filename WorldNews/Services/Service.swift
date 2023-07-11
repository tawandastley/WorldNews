//
//  Services.swift
//  WorldNews
//
//  Created by Tawanda Chandiwana on 2023/07/03.
//

import UIKit
import SafariServices

class Service: UIViewController {
    
    func fetchArticles(completion: @escaping(NewsArticles)-> Void) {
        let url = "https://newsapi.org/v2/everything?q=apple&from=2023-07-02&to=2023-07-02&sortBy=popularity&apiKey=ec44405378314f5eb754470cd0f98af4"
        guard let formatedURL = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: formatedURL) { data, response, error in
            if error == nil , data != nil {
                
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(NewsArticles.self, from: data!)
                    completion(decodedData)
                }
                catch {
                    print(error)
                }
            }
            else if error != nil{
                
            }
        }
        task.resume()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
}
