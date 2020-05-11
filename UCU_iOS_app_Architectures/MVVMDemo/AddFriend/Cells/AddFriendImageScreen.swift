//
//  AddFriendThirdScreenCell.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

final class AddFriendImageScreen: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var previewImage: UIImageView!
    
    // MARK: - Properties
    private let photoManager = PhotoManager()
    weak var vc: UIViewController?
    
    // MARK: - Rx
    let imageChanged = PublishRelay<UIImage>()

    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareBind()
    }
    
    // MARK: - Private
    private func prepareBind() {
        photoManager.imageURL.bind { [weak self] url in
            let data = try? Data(contentsOf: url)
            if let image = UIImage(data: data!) {
                DispatchQueue.main.async {
                    self?.previewImage.image = image
                    self?.imageChanged.accept(image)
                    MBProgressHUD.hide(for: self!, animated: true)
                }
            }
        }.disposed(by: rx.disposeBag)
    }
    
    // MARK: - IBActions
    @IBAction private func libraryTapped(_ sender: Any) {
        MBProgressHUD.showAdded(to: self, animated: true)
        photoManager.managePhoto(vc: vc!, sourceType: .photoLibrary)
    }
}
