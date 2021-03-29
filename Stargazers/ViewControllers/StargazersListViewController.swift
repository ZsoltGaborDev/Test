//
//  StargazersListViewController.swift
//  Stargazers
//
//  Created by zsolt on 28/03/2021.
//

import UIKit

class StargazersListViewController: UITableViewController {

    let stargazerCell = "stargazerCell"
    let pageName = "Stargazers"
    
    var users: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pageName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: stargazerCell) as? StargazerTableViewCell

        guard let customCell = cell else {
            return UITableViewCell()
        }

        cell?.configure(users[indexPath.row])
        return customCell
    }
}
