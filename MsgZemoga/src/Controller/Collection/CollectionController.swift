//
//  CollectionController.swift
//  MsgZemoga
//
//  Created by user222400 on 6/30/22.
//

import Foundation
import UIKit

class CollectionController{
    

    func setPostCell(post: PostCellCT, posts: [PostEntity], index: Int) -> PostCellCT{
        var postCell = post
        
        postCell.postId = Int(posts[index].id)
        postCell.userId = Int(posts[index].userId)
        postCell.arrayPosition = index
        
        postCell.postTitle.text = posts[index].title
        postCell.isFavorite = posts[index].isFavorite
        
        if posts[index].isFavorite {
            postCell.favIcon.image = UIImage(systemName: "star.fill")
        } else{
            postCell.favIcon.image = UIImage(systemName: "star")
        }
        postCell = setCardCustomization(post: postCell)
        
        return postCell
    }
    
    func setCommentCell(){
        
    }
    
    
    private func setCardCustomization(post: PostCellCT) -> PostCellCT {
        
        post.contentView.layer.cornerRadius = 4.0
        post.contentView.layer.borderWidth = 1.0
        post.contentView.layer.borderColor = UIColor.clear.cgColor
        post.contentView.layer.masksToBounds = false
        post.layer.shadowColor = UIColor.gray.cgColor
        post.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        post.layer.shadowRadius = 4.0
        post.layer.shadowOpacity = 1.0
        post.layer.masksToBounds = false
        post.layer.shadowPath = UIBezierPath(roundedRect: post.bounds, cornerRadius: post.contentView.layer.cornerRadius).cgPath
        
        return post
    }
    
}
