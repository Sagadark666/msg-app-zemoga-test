//
//  File.swift
//  MsgZemoga
//
//  Created by user222400 on 6/27/22.
//

import Foundation

class ApiControllerTwo {

    var endpoint = "https://jsonplaceholder.typicode.com/posts/"
    //var posts =  [Post]()
    
    func fetchPosts(postId: Int, completionHandler: @escaping (PostDetail) -> Void){
        
        endpoint = endpoint + String(postId)
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
                            completionHandler(try decoder.decode(PostDetail.self, from:data))
                        } catch {
                            print(error)
                        }
            
                 }
        })
        getData.resume()
        
    }
}

