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

    //var post = PostDetail(userId: 0, title: "", body: "")
    var postId : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiControllerTwo().fetchPosts(postId: postId){
            [weak self] (post) in

            DispatchQueue.main.async {
                self?.detailTitle.text = post.title
                self?.detailDescription.text = post.body
            }
            	
        }
    }
    

    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loadPost"{
            guard let postsVC = segue.source as?
                    ViewController else {return}
            postsVC.delegate = self
            
        }
    }*/
}
