//
//  ApiController.swift
//  MsgZemoga
//
//  Created by user222400 on 6/26/22.
//

import Foundation

class ApiController {

    let endpoint = URL(string: "https://jsonplaceholder.typicode.com/posts")
    //var posts =  [Post]()
    
    func fetchPosts(completionHandler: @escaping ([Post]) -> Void){
        
        let request = URLRequest(url: endpoint!)
        let getData = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
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
                completionHandler(self.parseJsonData(data: data))
            }
        
        })
        getData.resume()
        
    }
    
    func parseJsonData(data: Data) -> [Post]{
        let decoder = JSONDecoder()
        
        var posts = [Post]()
         
            do {
                posts = try decoder.decode([Post].self, from: data)
         
            } catch {
                print(error)
            }
         
            return posts
    }
}
