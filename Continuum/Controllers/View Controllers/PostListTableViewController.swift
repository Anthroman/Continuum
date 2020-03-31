//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Anthroman on 3/31/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        let post = PostController.shared.posts[indexPath.row]
        
        cell.post = post
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? PostDetailTableViewController else {return}
            let post = PostController.shared.posts[indexPath.row]
            destinationVC.post = post
        }
    }
}
