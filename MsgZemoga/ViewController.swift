//
//  ViewController.swift
//  MsgZemoga
//
//  Created by user222400 on 6/26/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
      
    let api = ApiController()
    var posts = [Post]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let post = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCellCT
        
        post.postTitle.text = posts[indexPath.row].title
        post.postAuthor.text = String(posts[indexPath.row].id)
        
        return post
    }
    
    func reloadPost(){
        collectionView.reloadData()
    }
    
}
