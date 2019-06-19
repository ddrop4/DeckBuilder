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

    var cards: CardsDetail? {
        didSet {
            nameLabel.text = cards?.name
        }
    }
    
    func downloadImage(url: String) {
        if let imageUrl = URL(string: url) {
            downloadImage(url: imageUrl) { [weak self] (imageData) in
                self?.imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func downloadImage(url: URL, completion:((Data)->())?) {
        print("Download Started")
        NetworkService().getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                print(data)
                completion?(data)
            }
        }
    }
}
