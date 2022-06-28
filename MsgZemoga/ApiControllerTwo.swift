//
//  File.swift
//  MsgZemoga
//
//  Created by user222400 on 6/27/22.
//

import Foundation

class ApiControllerTwo {

    let endpoint = URL(string: "https://jsonplaceholder.typicode.com/posts/1")
    //var posts =  [Post]()
    
    func fetchPosts(completionHandler: @escaping (PostDetail) -> Void){
        
        let request = URLRequest(url: endpoint!)
        let getData = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
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
                
                completionHandler(try decoder.decode(PostDetail.self, from:data))
                // Reload table view
                //OperationQueue.main.addOperation({
                //self.tableView.reloadData()
                //})
            }
        
        })
        getData.resume()
        
    }
}
