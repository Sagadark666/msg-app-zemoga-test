//
//  ApiControllerThree.swift
//  MsgZemoga
//
//  Created by user222400 on 6/28/22.
//

import Foundation

class ApiControllerThree {

    var endpoint = "https://jsonplaceholder.typicode.com/users/"
    
    func fetchPosts(userId: Int, completionHandler: @escaping (User) -> Void){
        
        endpoint = endpoint + String(userId)
        let urlRequest = URL(string: endpoint)
        
        let request = URLRequest(url: urlRequest!)
    
        let getData = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            
                 if let error = error {
                     print(error)
                     return
                 }
                 
                 guard let httpResponse = response as? HTTPURLResponse,
                       (200...299).contains(httpResponse.statusCode) else {
                     print("Error with the response, unexpected status code: \(response)")
                     return
                 }
                 
                 // Parse JSON data
                 if let data = data {
                     let decoder = JSONDecoder()
                    
                        do {
                            let user = try decoder.decode(User.self, from:data)
                            completionHandler(user)
                        } catch {
                            print(error)
                        }
            
                 }
        })
        getData.resume()
        
    }
}

