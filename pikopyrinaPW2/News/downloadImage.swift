//
//  downloadImage.swift
//  pikopyrinaPW2
//
//  Created by Polina Kopyrina on 08.12.2022.
//

import UIKit

extension UIImageView {
    @discardableResult
    func download(from url: URL) -> Data? {
        var downloadedData: Data? = nil
        let downloadTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard
                let data = data,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
            downloadedData = data
        }
        
        downloadTask.resume()
        return downloadedData
    }
}
