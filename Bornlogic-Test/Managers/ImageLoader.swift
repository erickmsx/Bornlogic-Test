//
//  ImageLoader.swift
//  Bornlogic-Test
//
//  Created by Erick Martins on 11/05/24.
//

import Foundation
import UIKit

class ImageLoader {
    static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        // Use URLSession para baixar a imagem da URL
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}
