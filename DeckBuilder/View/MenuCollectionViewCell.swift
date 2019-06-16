//
//  MenuCollectionViewCell.swift
//  DeckBuilder
//
//  Created by Anton Chernyshev on 03/05/2019.
//  Copyright © 2019 Anton Chernyshev. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func getJSON() {
        guard let url = URL(string: "https://api.hearthstonejson.com/v1/25770/ruRU/cards.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let cards = try JSONDecoder().decode([Menu].self, from: data)
                DispatchQueue.main.sync() {
                    self.nameLabel.text = "$\(cards.last)"
                }
            } catch {
                print("Error:", error)
            }
            }.resume()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    var menu: Menu? {
        didSet {
            nameLabel.text = menu?.name
        }
    }
}
