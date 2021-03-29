//
//  SearchViewController.swift
//  Stargazers
//
//  Created by zsolt on 28/03/2021.
//

import UIKit

class SearchViewController: UIViewController {

    let stargazersVC = "StargazersTableViewController"
    let storyboardId = "Main"
    let pageName = "Home"
    
    @IBOutlet weak var ownerTextField: UITextField?
    @IBOutlet weak var repoTextField: UITextField?

    @IBOutlet weak var searchButton: UIButton?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        self.title = pageName
        ownerTextField?.delegate = self
        repoTextField?.delegate = self
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let owner = ownerTextField?.text, owner.count > 0,
            let repo = repoTextField?.text, repo.count > 0 else {
            return
        }
        self.activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        ApiController.getStargazers(by: owner, repo: repo) { (result) in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true

            switch result {
                case .success(let stargazer):
                    self.presentStargazersTableViewController(with: stargazer)
                case .failure(let error):
                   self.presentErrorView(with: error.localizedDescription)
            }
        }
    }

    private func presentErrorView(with message: String) {
        let alert = UIAlertController(title: "",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }

    private func presentStargazersTableViewController(with users: [User]) {
        guard let vc = UIStoryboard(name: storyboardId, bundle: nil)
            .instantiateViewController(withIdentifier: stargazersVC) as? StargazersListViewController else {
            return
        }
        vc.users = users
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
