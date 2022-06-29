//
//  PostCell.swift
//  MsgZemoga
//
//  Created by user222400 on 6/27/22.
//

import UIKit

class PostCellCT: UICollectionViewCell {
    
    var postId: Int!
    var arrayPosition: Int!
    var userId: Int!
    var isFavorite : Bool?
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
}
