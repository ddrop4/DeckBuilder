//
//  ViewController.swift
//  DeckBuilder
//
//  Created by Anton Chernyshev on 03/05/2019.
//  Copyright © 2019 Anton Chernyshev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var itemMenuArray: [Menu] = {
        var cardMenu = Menu()
        cardMenu.name = "Leeroy"
        cardMenu.imageName = "Leeroy"
        
        var cardMenu2 = Menu()
        cardMenu2.name = "Dr. Boom"
        cardMenu2.imageName = "doctorboom"
        return [cardMenu, cardMenu2]
    }()
    
    // MARK: - UI

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVC" {
            if let vc = segue.destination as? DetailViewController {
                let menu = sender as? Menu
                print(menu ?? "nil")
                vc.menu = menu
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemMenuArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell {
            itemCell.menu = itemMenuArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = itemMenuArray[indexPath.row]
        self.performSegue(withIdentifier: "showVC", sender: menu)
        
    }
}

