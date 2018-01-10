//
//  DKImagePickerController+Extension
//  Sparrow
//
//  Created by Joey on 20/11/2017.
//

import DKImagePickerController
import RxSwift
import UIKit

public extension Reactive where Base: DKImagePickerController {
    public static func present(selectedItems: [DKAsset] = [], limit: Int = 9) -> Observable<[DKAsset]> {
        return Observable<[DKAsset]>.create { observer in
            let vc = DKImagePickerController()
            let visibleVC = UIApplication.shared.keyWindow?.visibleViewController
            visibleVC?.present(vc, animated: true, completion: nil)
            
            vc.assetType = .allPhotos
            vc.defaultSelectedAssets = selectedItems
            vc.maxSelectableCount = limit
            
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
    }
}

public extension Reactive where Base: DKAsset {
    public func load(_ size: CGSize) -> Observable<(id:String, image: UIImage)> {
        let localId = self.base.localIdentifier
        return Observable<(id:String, image: UIImage)>
            .create { observer in
                let scaledSize = CGSize(width: size.width * UIScreen.main.scale, height: size.height * UIScreen.main.scale)
                self.base.fetchImageWithSize(scaledSize) { (image, _) in
                    observer.onNext((localId, image!))
                }
                return Disposables.create()
            }
            .debug()
    }
    
    public func origin() -> Observable<(id:String, image: UIImage)> {
        let localId = self.base.localIdentifier
        return Observable<(id:String, image: UIImage)>
            .create { observer in
                self.base.fetchOriginalImage(false) { (image, _) in
                    observer.onNext((localId, image!))
                }
                return Disposables.create()
            }
            .debug()
    }
}
