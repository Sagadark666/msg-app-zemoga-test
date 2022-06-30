//
//  PostDashboardVC.swift
//  MsgZemoga
//
//  Created by user222400 on 6/26/22.
//

import UIKit
import CoreData

class PostDashboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ManagePostDelegate{
    
      
    let api = ApiController()
    let collectionController = CollectionController()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cachedPost = [PostEntity]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func reloadWasPressed(sender: UIBarButtonItem){
        api.getAllPosts{
            [weak self] (posts) in
            if (posts.count - self!.cachedPost.count) > 0 {
                if self!.cachedPost.isEmpty {
                    for post in posts {
                        let cachePost = PostEntity(context: self!.context)
                        cachePost.id = Int64(post.id)
                        cachePost.userId = Int64(post.userId)
                        cachePost.title = post.title
                        cachePost.isFavorite = post.isFavorite
                        
                        self?.cachedPost.append(cachePost)
                    }
                } else{
                    for post in posts {
                        let results = self!.cachedPost.filter { $0.id == post.id }
                        if results.isEmpty {
                            let cachePost = PostEntity(context: self!.context)
                            cachePost.id = Int64(post.id)
                            cachePost.userId = Int64(post.userId)
                            cachePost.title = post.title
                            cachePost.isFavorite = post.isFavorite
                            self!.cachedPost.insert(cachePost, at: 0)
                        }
                    }
                }
                do{
                    try self!.context.save()
                } catch{
                    print("Se esta rompiendo al refrescar")
                }
                DispatchQueue.main.async {
                    self?.reloadPost()
                }
            }
        }
    }
    
    @IBAction func deleteAllWasPressed(sender: UIBarButtonItem){
        for cachePost in cachedPost {
            context.delete(cachePost)
        }
        cachedPost.removeAll()
        do{
            try self.context.save()
        } catch{
            print("Se esta rompiendo al eliminar todo")
        }
        reloadPost()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cachedPost = fetchCachedData()
        if cachedPost.isEmpty{
            api.getAllPosts{
                [weak self] (posts) in
            
                for post in posts {
                    let cachePost = PostEntity(context: self!.context)
                    cachePost.id = Int64(post.id)
                    cachePost.userId = Int64(post.userId)
                    cachePost.title = post.title
                    cachePost.isFavorite = post.isFavorite
                    do{
                        try self!.context.save()
                    }catch{
                        print("Se esta rompiendo al inicializar")
                    }
                }
                DispatchQueue.main.async {
                    self?.reloadPost()
                }
            }
        }
        DispatchQueue.main.async {
            self.reloadPost()
        }
    }
    
    func fetchCachedData() -> [PostEntity]{
        var requestPost = [PostEntity]()
        do{
            requestPost = try context.fetch(PostEntity.fetchRequest())
        } catch{
            print("Se esta rompiendo al recuperar")
        }
        return requestPost
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PostDetailsVC {
            let postDetailVC = segue.destination as? PostDetailsVC
            let postCard = sender as! PostCellCT
            postDetailVC?.postId = postCard.postId
            postDetailVC?.userId = postCard.userId
            postDetailVC?.arrayPosition = postCard.arrayPosition
            postDetailVC?.isFavorite = postCard.isFavorite
        }
        if segue.identifier == "loadPost"{
            guard let postDetailsVC = segue.destination as?
                    PostDetailsVC else {return}
            postDetailsVC.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cachedPost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var post = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCellCT
        post = collectionController.setPostCell(post: post, posts: cachedPost, index: indexPath.row)
        return post
    }
    
    func reloadPost(){
        cachedPost.sort{$0.isFavorite && !$1.isFavorite}
        collectionView.reloadData()
    }
    
    func setDelete(postId: Int) {
        context.delete(cachedPost[postId])
        cachedPost.remove(at: postId)
        do {
            try context.save()
        }catch{
            print("Se esta rompiendo al eliminar")
        }
        reloadPost()
    }
    
    func setFavorite(postId: Int) {
        cachedPost[postId].isFavorite = !cachedPost[postId].isFavorite
        do {
            try context.save()
        }catch{
            print("Se esta rompiendo al agregar favorito")
        }
        reloadPost()
    }
    

    
}


