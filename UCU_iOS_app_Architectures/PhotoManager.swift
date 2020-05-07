//
//  PhotoManager.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit
import MobileCoreServices
import MBProgressHUD
import RxCocoa
import RxSwift

class PhotoManager: UIViewController {

    //MARK: - Properties
    var vc = UIViewController()
    private let pickerController = UIImagePickerController()
    var handlePhoto: ((_ image: String)-> Void)?
    let imageURL = PublishRelay<URL>()
    
    //MARK: - Actions
    func managePhoto(vc: UIViewController, sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            pickerController.sourceType = sourceType
            pickerController.delegate = self
            self.vc = vc
            pickerController.modalPresentationStyle = .fullScreen
            vc.present(pickerController, animated: true, completion: nil)
        }
    }
}

//MARK: - Extensions
extension PhotoManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        pickerController.dismiss(animated: true) {
            if let selectedImage = (info[.originalImage] as? UIImage)?.fixOrientation() {
                if let data = selectedImage.pngData() {
                    let file = "(Int(Date().timeIntervalSince1970)).PNG"
                    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        let fileURL = dir.appendingPathComponent(file)
                        do {
                            try data.write(to: fileURL, options: Data.WritingOptions.atomicWrite)
                            self.imageURL.accept(fileURL.absoluteURL)
                        } catch {
                        }
                    }
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController.dismiss(animated: true)
    }
}


