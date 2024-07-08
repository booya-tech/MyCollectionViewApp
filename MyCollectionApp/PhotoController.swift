//
//  PhotoController.swift
//  MyCollectionApp
//
//  Created by Panachai Sulsaksakul on 6/25/24.
//

// PhotoController.swift

import Foundation
import Alamofire

class PhotoController {
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        AF.request("https://api.500px.com/v1/photos?feature=popular&page=1")
            .validate()
            .responseDecodable(of: PhotosResponse.self) { response in
                switch response.result {
                case .success(let photosResponse):
                    completion(.success(photosResponse.photos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

struct PhotosResponse: Codable {
    let photos: [Photo]
}

