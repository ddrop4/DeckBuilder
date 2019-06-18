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
    
    struct CardId: Decodable {
        var id: String
    }
    
    @IBOutlet weak var detailCardImage: UIImageView!
    @IBOutlet weak var detailCardLabel: UILabel!
    
    var ids = [CardId]() {
        didSet {
            guard let first = ids.first else {
                return
            }
            guard let url = URL(string: "https://art.hearthstonejson.com/v1/render/latest/ruRU/512x/\(first.id).png") else { return }
            downloadImage(from: url)
            
        }
    }
    var cards = [CardsDetail]()
    
    func getId() {
        guard let url = URL(string: "https://api.hearthstonejson.com/v1/25770/ruRU/cards.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let id = try JSONDecoder().decode([CardId].self, from: data)
                DispatchQueue.main.async {
                    self.ids = id
                    print(self.ids)
                }
            } catch {
                print(error)
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
                self.detailCardImage.image = UIImage(data: data)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getId()
    }
}
