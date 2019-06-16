//
//  DetailViewController.swift
//  DeckBuilder
//
//  Created by Anton Chernyshev on 09/05/2019.
//  Copyright © 2019 Anton Chernyshev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    struct CardsDetail: Codable {
        var name: String
        var id: String
    }
    
    let id = "ART_BOT_Bundle_001.png"
    
    @IBOutlet weak var detailCardImage: UIImageView!
    @IBOutlet weak var detailCardLabel: UILabel!
    
    func getJSON() {
        guard let url = URL(string: "https://api.hearthstonejson.com/v1/25770/ruRU/cards.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let cards = try JSONDecoder().decode([CardsDetail].self, from: data)
                DispatchQueue.main.async {
                    self.detailCardLabel.text = CardsDetail.name
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
                self.detailCardImage.image = UIImage(data: data)
            }
        }
    }
    
    var menu: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://art.hearthstonejson.com/v1/render/latest/ruRU/512x/\(id)")!
        downloadImage(from: url)
        getJSON()
    }
}
