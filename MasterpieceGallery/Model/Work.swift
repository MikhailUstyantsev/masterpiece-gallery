//
//  Work.swift
//  MasterpieceGallery
//
//  Created by Mikhail Ustyantsev on 13.02.2024.
//

import Foundation

struct Work: Codable {
    let title: String
    let image: String
    let info: String
}


extension Work: Hashable {
    public static func == (lhs: Work, rhs: Work) -> Bool {
        return lhs.title == rhs.title
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
