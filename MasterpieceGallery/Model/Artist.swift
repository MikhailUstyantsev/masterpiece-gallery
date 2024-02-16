//
//  Artist.swift
//  MasterpieceGallery
//
//  Created by Mikhail Ustyantsev on 13.02.2024.
//

import Foundation

struct Artists: Codable {
    let artists: [Artist]
}

struct Artist: Codable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
    
}

extension Artist: Hashable {
    public static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}
