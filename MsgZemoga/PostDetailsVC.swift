//
//  PostDetailsVC.swift
//  MsgZemoga
//
//  Created by user222400 on 6/27/22.
//

import UIKit

class PostDetailsVC : UIViewController {
    
    
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorEmail: UILabel!
    @IBOutlet weak var authorPhone: UILabel!
    @IBOutlet weak var authorWebsite: UILabel!
    
    @IBOutlet weak var commentsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiControllerTwo.fetchPosts{
            [weak self] (posts) in
            self?.posts = posts
        }
        
    }
}
