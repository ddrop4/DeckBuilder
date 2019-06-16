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
    
    let url = URL(string: "https://api.hearthstonejson.com/v1/25770/ruRU/cards.json")!
    var itemMenuArray: [Menu] = {
        var cardMenu = Menu()
        cardMenu.name = ""
        
        var cardMenu2 = Menu()

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
    
    func getJSON() {
        guard let url = URL(string: "https://api.hearthstonejson.com/v1/25770/ruRU/cards.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let cards = try JSONDecoder().decode(Menu.self, from: data)
                DispatchQueue.main.sync() {
                    
                }
                print(cards)
            } catch {
                print("Error:", error)
            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(json)
//            } catch let jsonError {
//                print("Something went wrong, error:", jsonError)
//            }
            }.resume()
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

