//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Anthroman on 3/31/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    //MARK: - Properties
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        postImageView.image = post?.photo
        postCaptionLabel.text = post?.caption
        commentCountLabel.text = "Comments: \(String(describing: post?.commentCount))"
    }
}
