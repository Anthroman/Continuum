//
//  PostController.swift
//  Continuum
//
//  Created by Anthroman on 3/31/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostController {
    
    // Singleton
    static let shared = PostController()
    // Source of Truth
    var posts: [Post] = []
    
    //MARK: - CRUD
    
    func addComment(text: String, post: Post, completion: @escaping (Result<Comment, PostError>) -> Void) {
        
        let newComment = Comment(text: text, post: post)
        post.comments.append(newComment)
    }
    
    func createPostWith(photo: UIImage, caption: String, comments: [Comment], completion: @escaping (Result<Post?, PostError>) -> Void) {
        
        let newPost = Post(photo: photo, caption: caption)
        PostController.shared.posts.append(newPost)
    }
}
