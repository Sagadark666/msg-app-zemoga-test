//
//  ViewController.swift
//  MsgZemoga
//
//  Created by user222400 on 6/26/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
      
    let api = ApiController()
    var posts = [Post]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func reloadWasPressed(sender: UIBarButtonItem){
        api.fetchPosts{
            [weak self] (posts) in
            self?.posts = posts
            
            DispatchQueue.main.async {
                self?.reloadPost()
            }
        }
    }
    
    @IBAction func deleteAllWasPressed(sender: UIBarButtonItem){
        posts.removeAll()
        reloadPost()
    }
    
    
    //var delegate : PostOpenDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.fetchPosts{
            [weak self] (posts) in
            self?.posts = posts
            
            DispatchQueue.main.async {
                self?.reloadPost()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PostDetailsVC {
            let postDetailVC = segue.destination as? PostDetailsVC
            let postCard = sender as! PostCellCT
            postDetailVC?.postId = postCard.postId
            postDetailVC?.userId = postCard.userId
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let post = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCellCT
        
        post.postId = posts[indexPath.row].id
        post.userId = posts[indexPath.row].userId
        
        post.postTitle.text = posts[indexPath.row].title
        post.favIcon.image = UIImage(named: "star-off")
        
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
    
    
    
    func reloadPost(){
        collectionView.reloadData()
    }
    
}
