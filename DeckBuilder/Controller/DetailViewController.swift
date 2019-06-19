//
//  DetailViewController.swift
//  DeckBuilder
//
//  Created by Anton Chernyshev on 09/05/2019.
//  Copyright © 2019 Anton Chernyshev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailCardImage: UIImageView!
    @IBOutlet weak var detailCardLabel: UILabel!
    
    var cards = CardsDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService().getId()
    }
}

func downloadImage(from url: URL) {
    print("Download Started")
    NetworkService().getData(from: url) { data, response, error in
        guard let data = data, error == nil else { return }
        print(response?.suggestedFilename ?? url.lastPathComponent)
        print("Download Finished")
        DispatchQueue.main.async() {
            print(data)
        }
    }
}
