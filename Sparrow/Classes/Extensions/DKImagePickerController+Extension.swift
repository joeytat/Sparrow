//
//  DKImagePickerController+Extension
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import DKImagePickerController
import RxSwift
import UIKit
import Photos

public extension Reactive where Base: DKImagePickerController {
    public static func present(selectedItems: [DKAsset] = [],
                               limit: Int = 9,
                               authDesc: String = "请在「设置」中开启照片读取和写入功能",
                               dkPickerSetup: @escaping (_ picker: DKImagePickerController) -> Void = { _ in } ) -> Observable<[DKAsset]> {
        guard let visibleVC = UIApplication.shared.keyWindow?.visibleViewController else { return .never() }
        
        let auth: Observable<Bool> = {
            if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .notDetermined {
                return .just(true)
            } else {
                return UIAlertController.rx
                    .presentConfirmAlert(by: visibleVC, title: authDesc)
                    .do(onNext: { n in
                        if n {
                            Device.openSettings()
                        }
                    })
            }
        }()
        
        let present = Observable<[DKAsset]>.create { observer in
            let vc = DKImagePickerController()
            visibleVC.present(vc, animated: true, completion: nil)
            
            vc.assetType = .allPhotos
            vc.setSelectedAssets(assets: selectedItems)
            vc.maxSelectableCount = limit
            dkPickerSetup(vc)
            
            vc.didCancel = {[unowned vc] in
                observer.onNext(vc.selectedAssets)
                observer.onCompleted()
            }
            vc.didSelectAssets = {assets in
                observer.onNext(assets)
                observer.onCompleted()
            }
            return Disposables.create {}
        }
        return auth.filter { $0 }.flatMap { _ in present }
    }
}

public extension Reactive where Base: DKAsset {
    public func load(_ size: CGSize, options: PHImageRequestOptions? = nil) -> Observable<(id:String, image: UIImage)> {
        let localId = self.base.localIdentifier
        return Observable<(id:String, image: UIImage)>
            .create { observer in
                let scaledSize = CGSize(width: size.width * UIScreen.main.scale, height: size.height * UIScreen.main.scale)
                self.base.fetchImage(with: scaledSize,
                                     options: options,
                                     contentMode: PHImageContentMode.default) {  (image, dict) in
                                        if let image = image {
                                            observer.onNext((localId, image.fixRotation()))
                                            observer.onCompleted()
                                        } else {
                                            observer.onError(DKImagePickerError.originFailed)
                                        }
                }
                return Disposables.create()
        }
    }
    
    public func origin(_ options: PHImageRequestOptions? = nil) -> Observable<(id:String, image: UIImage)> {
        let localId = self.base.localIdentifier
        return Observable<(id:String, image: UIImage)>
            .create { observer in
                self.base.fetchOriginalImage(options: options) { (image, error) in
                    if let image = image {
                        observer.onNext((localId, image.fixRotation()))
                        observer.onCompleted()
                    } else {
                        observer.onError(DKImagePickerError.originFailed)
                    }
                }
                return Disposables.create()
        }
    }
}

enum DKImagePickerError: Error {
    case originFailed
    case loadFailed
}
