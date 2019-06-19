//
//  ViewController.swift
//  DeckBuilder
//
//  Created by Anton Chernyshev on 03/05/2019.
//  Copyright © 2019 Anton Chernyshev. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageGroup = DispatchGroup()
    func getActivities() {
        for i in 0...3 {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else { return }
            imageGroup.enter()
            DispatchQueue.main.async {
//                downloadImage(url: url, completion: { (imageData) -> () in
//                    
//                })
                print("\(i) tasks is done")
                self.imageGroup.leave()
            }
        }
        print("All task is done")
    }
    
    var itemMenuArray: [CardsDetail] = {
        var cardMenu = CardsDetail()
        cardMenu.name = "Leeroy"
        cardMenu.id = ""
        
        var cardMenu2 = CardsDetail()
        cardMenu2.name = "Dr. Boom"
        cardMenu2.id = ""
        
        return [cardMenu, cardMenu2]
    }()
    
    // MARK: - UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        getActivities()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVC" {
            if let vc = segue.destination as? DetailViewController {
                let cards = sender as? CardsDetail
                print(cards ?? "nil")
                vc.cards = cards!
            }
        }
    }
}

//func downloadImage(url: URL, completion:((Data)->())?) {
//    print("Download Started")
//    NetworkService().getData(from: url) { data, response, error in
//        guard let data = data, error == nil else { return }
//        print(response?.suggestedFilename ?? url.lastPathComponent)
//        print("Download Finished")
//        DispatchQueue.main.async() {
//            print(data)
//            completion?(data)
//        }
//    }
//}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemMenuArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell {
            itemCell.cards = itemMenuArray[indexPath.row]
            itemCell.downloadImage(url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg/800px-An_up-close_picture_of_a_curious_male_domestic_shorthair_tabby_cat.jpg")
            return itemCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cards = itemMenuArray[indexPath.row]
        self.performSegue(withIdentifier: "showVC", sender: cards)
        
        }
    }
