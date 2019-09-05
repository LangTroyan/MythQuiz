//
//  APIService.swift
//  Myth Quiz
//
//  Created by Trujillo Baez, Dylan Alfonso (ES - Barcelona) on 04/09/2019.
//  Copyright © 2019 Dylan Trujillo. All rights reserved.
//

import UIKit

enum Result<T>{
    case Success(T)
    case Error(String)
}

class APIService: NSObject {
    
    //MARK: Properties
    let baseUrl: String = "https://opentdb.com/api.php?amount=4&category=20&type=multiple"
    
    //MARK: Method
    func getData(completition: @escaping (Result<[[String : AnyObject]]>) -> Void){
        guard let url = URL(string: baseUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return completition(.Error(error?.localizedDescription ?? "Invalid URL")) }
            guard let data = data else { return completition(.Error(error?.localizedDescription ?? "No data to show")) }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String : AnyObject] {
                    DispatchQueue.main.async {
                        if let result = json["results"] as? [[String : AnyObject]] {
                            completition(.Success(result))
                        }
                        else{
                            completition(.Error("Result could not be parsed"))
                        }
                        
                    }
                }
            }
            catch let error {
                return completition(.Error(error.localizedDescription))
            }
        }.resume()
    }
}
