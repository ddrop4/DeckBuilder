//
//  DetailViewController.swift
//  DeckBuilder
//
//  Created by Anton Chernyshev on 09/05/2019.
//  Copyright © 2019 Anton Chernyshev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailCardImage: UIImageView! {
        didSet {
            guard let image = menu?.imageName else { return }
            detailCardImage.image = UIImage(named: image)
        }
    }
    @IBOutlet weak var detailCardLabel: UILabel! {
        didSet {
            detailCardLabel.text = menu?.name
        }
    }
    
    var menu: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
