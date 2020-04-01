//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Anthroman on 3/31/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {

    //MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var selectImageButtonImageView: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captionTextField.text = ""
        selectImageButtonImageView.titleLabel?.text = "Select Image"
        postImageView.image = nil
    }

    //MARK: - Actions
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        selectImageButtonImageView.titleLabel?.text = ""
        postImageView.image = UIImage(named: "spaceEmptyState")
        
    }
    
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        guard let photo = postImageView.image, let caption = captionTextField.text else {return}
        
        PostController.shared.createPostWith(photo: photo, caption: caption) { (_) in
        }
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
    }
}
