//
//  PhotosAsset.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/26.
//

import Photos
import PhotosUI

class PhotosAsset: NSObject, PhotosAssetManageable {
    private var photos = PHAsset.fetchAssets(with: .none)
    private let cachingManager = PHCachingImageManager()
    private let ciContext = CIContext()
    private let formetIdentifier = "PhotosAsset"
    private let formatVersion = "1"
    
    override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
    }
    
    func count() -> Int {
        return photos.count
    }
    
    func getPhoto(at indexPath: IndexPath) -> PHAsset {
        return photos.object(at: indexPath.item)
    }
    
    func requestImage(with item: Int, completion: @escaping (UIImage?, [AnyHashable: Any]?) -> ()) {
        let photo = photos.object(at: item)
        cachingManager.requestImage(for: photo,
                                  targetSize: CGSize(width: Photo.Size.width, height: Photo.Size.height),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: completion)
    }
    
    func requestLivePhoto(with item: Int, completion: @escaping (PHLivePhoto?, [AnyHashable: Any]?) -> ()) {
        // Request the live photo for the asset from the default PHImageManager.
        let photo = photos.object(at: item)
        PHImageManager.default().requestLivePhoto(for: photo,
                                                  targetSize: CGSize(width: Photo.Size.width, height: Photo.Size.height),
                                                  contentMode: .aspectFit,
                                                  options: .none,
                                                  resultHandler: completion)
    }
    
    func adjustFilter(name filterName: String, to indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            filtering(name: filterName, to: indexPath)
        }
    }
    
    private func filtering(name filterName: String, to indexPath: IndexPath) {
        let photo = photos.object(at: indexPath.item)
        
        photo.requestContentEditingInput(with: .none) { (input, _) in
            guard let input = input else { return }
            DispatchQueue.global().async {
                guard let data = filterName.data(using: .utf8) else { return }
                let adjustmentData = PHAdjustmentData(formatIdentifier: self.formetIdentifier,
                                                    formatVersion: self.formatVersion,
                                                    data: data)
                let output = PHContentEditingOutput(contentEditingInput: input)
                output.adjustmentData = adjustmentData
                
                let completion = { () -> () in
                    PHPhotoLibrary.shared().performChanges({
                        let request = PHAssetChangeRequest(for: photo)
                        request.contentEditingOutput = output
                    })
                }
                
                if photo.mediaSubtypes.contains(.photoLive) {
                    self.adjustLivPhotoFilter(name: filterName, input: input, output: output, completion: completion)
                } else if photo.mediaType == .image {
                    self.adjustPhotoFilter(name: filterName, input: input, output: output, completion: completion)
                } // 동영상이면?
            }
        }
    }
    
    private func adjustPhotoFilter(name filterName: String, input: PHContentEditingInput, output: PHContentEditingOutput, completion: () -> ()) {
        guard let url = input.fullSizeImageURL,
              let inputImage = CIImage(contentsOf: url) else { return }
        let outputImage = inputImage.applyingFilter(filterName, parameters: [:])
        guard let colorSpace = inputImage.colorSpace else { return }
        try? self.ciContext.writeJPEGRepresentation(of: outputImage,
                                                    to: output.renderedContentURL,
                                                    colorSpace: colorSpace)
        completion()
    }
    
    private func adjustLivPhotoFilter(name filterName: String, input: PHContentEditingInput, output: PHContentEditingOutput, completion: @escaping () -> ()) {
        guard let livePhotoContext = PHLivePhotoEditingContext(livePhotoEditingInput: input) else { return }
        
        livePhotoContext.frameProcessor = { frame, _ in
            return frame.image.applyingFilter(filterName, parameters: [:])
        }
        livePhotoContext.saveLivePhoto(to: output, options: .none) { (success, error) in
            guard success else { return }
            completion()
        }
    }
    
    func revertFilter(by indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            self.revert(by: indexPath)
        }
    }
    
    private func revert(by indexPath: IndexPath) {
        let photo = photos.object(at: indexPath.item)
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest(for: photo)
            request.revertAssetContentToOriginal()
        })
    }
    
    func isFiltered(_ indexPaths: [IndexPath]) -> Bool {
        var resources = [PHAssetResource]()
        
        indexPaths.forEach { indexPath in
            let photo = photos.object(at: indexPath.item)
            resources = PHAssetResource.assetResources(for: photo).filter { $0.type == .adjustmentData }
        }
        
        return resources.count == 1
    }
}

extension PhotosAsset: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changedPhotos = changeInstance.changeDetails(for: self.photos) else { return }
        self.photos = changedPhotos.fetchResultAfterChanges
        NotificationCenter.default.post(name: Photo.NotificationName.didChangePhotos, object: self)
    }
}
