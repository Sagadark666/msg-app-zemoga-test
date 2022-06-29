//
//  PostClass.swift
//  MsgZemoga
//
//  Created by user222400 on 6/26/22.
//

import Foundation


struct Post : Codable{

    var id: Int
    var userId : Int
    var title : String
    var isFavorite : Bool = false
    
    private enum CodingKeys: String, CodingKey {
            case id, userId, title
        }
    
}	
