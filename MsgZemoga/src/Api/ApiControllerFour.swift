//
//  ApiControllerFour.swift
//  MsgZemoga
//
//  Created by user222400 on 6/28/22.
//

import Foundation

class ApiControllerFour {

    var endpoint = "https://jsonplaceholder.typicode.com/comments?postId="
    //var posts =  [Post]()
    
    func fetchPosts(postId : Int, completionHandler: @escaping ([Comment]) -> Void){
        
        endpoint = endpoint + String(postId)
        let urlRequest = URL(string: endpoint)
        
        let request = URLRequest(url: urlRequest!)
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
    
    func parseJsonData(data: Data) -> [Comment]{
        let decoder = JSONDecoder()
        
        var comments = [Comment]()
         
            do {
                comments = try decoder.decode([Comment].self, from: data)
         
            } catch {
                print(error)
            }
         
            return comments
    }
}
