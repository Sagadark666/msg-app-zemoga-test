//
//  RequestHandler.swift
//  MsgZemoga
//
//  Created by user222400 on 6/29/22.
//

import Foundation

class RequestHandler{
    
    func sendRequest<model: Codable>(request: String, of: model.Type = model.self, completionHandler: @escaping (model) -> Void){
    
        let getData = URLSession.shared.dataTask(with: URL(string: request)!, completionHandler: {(data, response, error) in
            
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
                do{
                    completionHandler(try decoder.decode(model.self, from: data))
                }catch{}
            }
        
        })
        getData.resume()
    }

}
