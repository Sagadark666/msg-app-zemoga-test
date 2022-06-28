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
    
    var postId : Int!
    var userId : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiControllerTwo().fetchPosts(postId: postId){
            [weak self] (post) in
            
            DispatchQueue.main.async {
                self?.detailTitle.text = post.title
                self?.detailDescription.text = post.body
            }
        }
        
        ApiControllerThree().fetchPosts(userId: userId){
            [weak self] (user) in
            
            DispatchQueue.main.async {  
                self?.authorName.text = user.name
                self?.authorEmail.text = user.email
                self?.authorPhone.text = user.phone
                self?.authorWebsite.text = user.website
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
