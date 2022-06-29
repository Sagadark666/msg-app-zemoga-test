//
//  PostDetailsVC.swift
//  MsgZemoga
//
//  Created by user222400 on 6/27/22.
//

import UIKit

class PostDetailsVC : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorEmail: UILabel!
    @IBOutlet weak var authorPhone: UILabel!
    @IBOutlet weak var authorWebsite: UILabel!
    
    @IBOutlet weak var commentsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var FavButton: UIBarButtonItem!
    
    @IBAction func deletePost(sender: UIBarButtonItem){
        delegate?.setDelete(postId: arrayPosition)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToFavorites(sender: UIBarButtonItem){
        delegate?.setFavorite(postId: arrayPosition)
        self.navigationController?.popViewController(animated: true)
    }
    
    var api = ApiController()
    var postId : Int!
    var userId : Int!
    var isFavorite : Bool!
    var arrayPosition : Int!
    var comments = [Comment]()
    
    var delegate : ManagePostDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isFavorite){
            FavButton.image = UIImage(systemName: "star.fill")
        }
    
        api.getPostDetails(postId: postId){
            [weak self] (post) in
            
            DispatchQueue.main.async {
                self?.detailTitle.text = post.title
                self?.detailDescription.text = post.body
            }
        }
        
        api.getUserInfo(userId: userId){
            [weak self] (user) in
            
            DispatchQueue.main.async {  
                self?.authorName.text = user.name
                self?.authorEmail.text = user.email
                self?.authorPhone.text = user.phone
                self?.authorWebsite.text = user.website
            }
        }
        
        api.getAllComments(postId: postId){
            [weak self] (comments) in
            self?.comments = comments
            
            DispatchQueue.main.async {
                self?.reloadPost()
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let comment = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCellCT
        
        comment.emailComment.text = comments[indexPath.row].email
        comment.bodyComment.text = comments[indexPath.row].body
        
        comment.contentView.layer.cornerRadius = 4.0
        comment.contentView.layer.borderWidth = 1.0
        comment.contentView.layer.borderColor = UIColor.clear.cgColor
        comment.contentView.layer.masksToBounds = false
        comment.layer.shadowColor = UIColor.gray.cgColor
        comment.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        comment.layer.shadowRadius = 4.0
        comment.layer.shadowOpacity = 1.0
        comment.layer.masksToBounds = false
        comment.layer.shadowPath = UIBezierPath(roundedRect: comment.bounds, cornerRadius: comment.contentView.layer.cornerRadius).cgPath
        
        return comment
    }
    
    
    
    func reloadPost(){
        commentsCollectionView.reloadData()
    }
}
