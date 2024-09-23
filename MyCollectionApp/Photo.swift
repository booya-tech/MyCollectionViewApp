//
//  Photo.swift
//  MyCollectionApp
//
//  Created by Panachai Sulsaksakul on 6/25/24.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let createdAt: String
    let imageURLs: [String]
    let height: CGFloat = CGFloat.random(in: 200...400)
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case imageURLs = "image_url"
    }
}



