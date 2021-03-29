//
//  StargazerTableViewCell.swift
//  Stargazers
//
//  Created by zsolt on 28/03/2021.
//

import UIKit

class StargazerTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    func configure(_ stargazer: User) {
        self.userNameLabel.text = stargazer.name
        self.avatarImageView.downloadedFrom(link: stargazer.avatar)
    }
}

private extension UIImageView {
    private func downloadImage(url: URL, contentMode mode: UIView.ContentMode) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadImage(url: url, contentMode: mode)
    }
}
