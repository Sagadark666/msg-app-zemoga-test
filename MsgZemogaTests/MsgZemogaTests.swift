//
//  MsgZemogaTests.swift
//  MsgZemogaTests
//
//  Created by user222400 on 6/26/22.
//

import XCTest
@testable import MsgZemoga

class MsgZemogaTests: XCTestCase {
    
    func testRequestHandlerResponse(){
        let resquestHandler = RequestHandler()
        let requestAssertion = User(name: "Kurtis Weissnat", email: "Telly.Hoeger@billy.biz", phone: "210.067.6132", website: "elvis.io")
        resquestHandler.sendRequest(request: "https://jsonplaceholder.typicode.com/users", of: [User].self){
         (users) in
            XCTAssertNotNil(users)
            XCTAssertEqual(users[6].name, requestAssertion.name)
            XCTAssertEqual(users[6].email, requestAssertion.email)
            XCTAssertEqual(users[6].phone, requestAssertion.phone)
            XCTAssertEqual(users[6].website, requestAssertion.website)
        }
    }
    
    let api = ApiController()
    
    func testApiResponseAllPosts(){

        let postsAssertion = Post(id: 79, userId: 8, title: "pariatur consequatur quia magnam autem omnis non amet", isFavorite: false)
        api.getAllPosts{ (posts) in
            XCTAssertNotNil(posts)
            XCTAssertEqual(posts[78].id, postsAssertion.id)
            XCTAssertEqual(posts[78].userId, postsAssertion.userId)
            XCTAssertEqual(posts[78].title, postsAssertion.title)
            XCTAssertEqual(posts[78].isFavorite, postsAssertion.isFavorite)
        }
        
    }
    
    func testApiResponseSinglePost(){
        
        let postAssertion = PostDetail(userId: 1,
                                       title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                                       body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        api.getPostDetails(postId: 1){ (post) in
            XCTAssertNotNil(post)
            XCTAssertEqual(post.userId, postAssertion.userId)
            XCTAssertEqual(post.title, postAssertion.title)
            XCTAssertEqual(post.body, postAssertion.body)
        }
    }

    func testApiResponseSingleUser(){
        
        let userAssertion = User(name: "Leanne Graham", email: "Sincere@april.biz", phone: "1-770-736-8031 x56442", website: "hildegard.org")
        api.getUserInfo(userId: 1){ (user) in
            XCTAssertNotNil(user)
            XCTAssertEqual(user.name, userAssertion.name)
            XCTAssertEqual(user.email, userAssertion.email)
            XCTAssertEqual(user.phone, userAssertion.phone)
            XCTAssertEqual(user.website, userAssertion.website)
        }
        
    }
    func testApiResponseAllComments(){
            
        let commentAsertion = Comment(
            email: "Nikita@garfield.biz",
            body: "quia molestiae reprehenderit quasi aspernatur\naut expedita occaecati aliquam eveniet laudantium\nomnis quibusdam delectus saepe quia accusamus maiores nam est\ncum et ducimus et vero voluptates excepturi deleniti ratione")
        api.getAllComments(postId: 1){ (comments) in
            XCTAssertNotNil(comments)
            XCTAssertEqual(comments[2].email, commentAsertion.email)
            XCTAssertEqual(comments[2].body, commentAsertion.body)
        }
    }
    
}

