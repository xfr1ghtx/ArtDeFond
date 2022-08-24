//
//  ImageManager.swift
//  ArtDeFond
//
//  Created by Someone on 20.08.2022.
//

import Foundation

import UIKit
import FirebaseStorage
import Kingfisher

protocol ImageManagerDescription {
    func upload(image: UIImage, completion: @escaping (Result<String, Error>) -> Void)
    func image(with name: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class ImageManager: ImageManagerDescription {
    static let shared: ImageManagerDescription = ImageManager()

    private let storageRef = Storage.storage().reference()

    private let cache = ImageCache.default

    private init() {}

    func upload(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            fatalError()
        }

        let imageName = UUID().uuidString

        storageRef.child(imageName).putData(data) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(imageName))
            }
        }
    }

    func image(with name: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        cache.retrieveImage(forKey: name) { [weak self] result in
            switch result {
            case .success(let imageResult):
                if let image = imageResult.image {
                    completion(.success(image))
                } else {
                    self?.download(imageName: name, completion: completion)
                }
            case .failure:
                self?.download(imageName: name, completion: completion)
            }
        }
    }

    private func download(imageName: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        storageRef.child(imageName).getData(maxSize: 5 * 1024 * 1024) { [weak self] data, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NetworkError.imageError))
                return
            }

            self?.cache.store(image, forKey: imageName)
            completion(.success(image))
        }
    }
}

enum NetworkError: Error {
    case shitHappens
    case imageError
    case two
    case three
    case four
}
