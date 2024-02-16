//
//  NetworkManager.swift
//  MasterpieceGallery
//
//  Created by Mikhail Ustyantsev on 13.02.2024.
//

import Foundation

class NetworkManager {
    
    static let shared   = NetworkManager()
    
    private init() {}
    
    func loadJson(filename fileName: String = R.Strings.artists, completed: @escaping (Result<Artists, MGError>) -> Void) {
        if let path = Bundle.main.path(forResource: fileName, ofType: R.Strings.json) {
            var url: URL?
            if #available(iOS 16.0, *) {
                url = URL(filePath: path)
            } else {
                url = URL(fileURLWithPath: path)
            }
            guard let url = url else { return }
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let artists = try decoder.decode(Artists.self, from: data)
                    completed(.success(artists))
                } catch {
                    completed(.failure(.invalidData))
                }
            }
    }
    
    
    
    
}
