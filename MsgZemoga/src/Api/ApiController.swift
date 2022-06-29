//
//  ApiController.swift
//  MsgZemoga
//
//  Created by user222400 on 6/26/22.
//

import Foundation

class ApiController {

    private let request = "https://jsonplaceholder.typicode.com/"
    private let requestHandler = RequestHandler()
    
    func getAllPosts(completionHandler: @escaping ([Post]) -> Void){
        let endpoint = "\(request)posts"
        requestHandler.sendRequest(request: endpoint, of: [Post].self) {posts in
            completionHandler(posts)
        }
    }
    
    func getPostDetails(postId: Int, completionHandler: @escaping (PostDetail) -> Void){
        let endpoint = "\(request)posts/\(postId)"
        requestHandler.sendRequest(request: endpoint, of: PostDetail.self) {postDetail in
            completionHandler(postDetail)
        }
    }
    
    func getUserInfo(userId: Int, completionHandler: @escaping (User) -> Void){
        let endpoint = "\(request)users/\(userId)"
        requestHandler.sendRequest(request: endpoint, of: User.self) {user in
            completionHandler(user)
        }
    }
    
    func getAllComments(postId: Int, completionHandler: @escaping ([Comment]) -> Void){
        let endpoint = "\(request)comments?postId=\(postId)"
        requestHandler.sendRequest(request: endpoint, of: [Comment].self) {comments in
            completionHandler(comments)
        }
    }
}
