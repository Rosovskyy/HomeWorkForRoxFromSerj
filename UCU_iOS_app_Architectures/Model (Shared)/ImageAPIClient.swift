//
//  ImageAPIClient.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

// MVC: Model
// -----------------
final class ImageAPIClient: Delayable {

    func loadImage(url imageUrl: String?, completion: @escaping(UIImage?) -> Void) {
        guard let imageUrl = imageUrl else { completion(nil); return }
        
        delay { // rox: simulate networking delay
            completion(Bundle.main.loadImage(imageUrl))
        }
    }
}

fileprivate extension Bundle {
    func loadImage(_ filename: String) -> UIImage? {
        guard let path = path(forResource: filename, ofType: "jpg") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return UIImage(data: data)
        } catch {
            
            return nil
        }
    }
}
