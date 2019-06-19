//
//  NetworkService.swift
//  DeckBuilder
//
//  Created by an.chernyshev on 19/06/2019.
//  Copyright © 2019 Anton Chernyshev. All rights reserved.
//

import Foundation

class NetworkService {
    
    var ids = [CardId]() {
        didSet {
            guard let first = ids.first else {
                return
            }
            guard let url = URL(string: "https://art.hearthstonejson.com/v1/render/latest/ruRU/512x/\(first.id).png") else {
                return
            }
            downloadImage(from: url)
        }
    }
    
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
}
