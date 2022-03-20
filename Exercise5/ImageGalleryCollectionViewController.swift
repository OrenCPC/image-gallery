//
//  ImageGalleryCollectionViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

class ImageGalleryCollectionViewController: UICollectionViewController
, UICollectionViewDelegateFlowLayout {
        
    private lazy var imageGalleryModel = ImageCollectionViewModel()
    
    private var width: CGFloat = 400

    var gallery: ImageGallery?
    
    var galleryWithoutImages: ImageGallery?{
        didSet {
            updateViewFromModel()
        }
    }


    
    @objc func adjustImagesScale(byHandlingGestureRecognizedBy recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            self.width *= recognizer.scale
            recognizer.scale = 1.0
            self.collectionView.reloadData()
        default: break
        }
    }
    
    private func updateCollectionView () {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func updateViewFromModel() {
        imageGalleryModel.getImages(gallery: galleryWithoutImages!) {images in
            gallery = galleryWithoutImages
            gallery?.images = images
        }
        updateCollectionView()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(adjustImagesScale(byHandlingGestureRecognizedBy:)))
        collectionView?.addGestureRecognizer(pinch)
        
        }
    
    func ratio(at indexPath: IndexPath) -> CGFloat {
        return gallery!.images[indexPath.item].ratio
    }

    func image(at indexPath: IndexPath) -> UIImage {
        return gallery!.images[indexPath.item].image.getImage()!
    }

    func calculatedSize(at indexPath: IndexPath)-> CGSize {
        let height = self.width / ratio(at: indexPath)
        return CGSize(width: self.width, height: height)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier,
           let destinationVC = segue.destination as? ImageViewController,
            let firstSelectedItem = collectionView.indexPathsForSelectedItems?.first,
           segueIdentifier == "cellToImage" {
            destinationVC.image = self.imageGalleryModel.images[firstSelectedItem.row].image.getImage()!
        }
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        performSegue(withIdentifier: "cellToImage", sender: self)
    }
        
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gallery?.images.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.image = image(at: indexPath).resizeImageTo(size: calculatedSize(at: indexPath))
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculatedSize(at: indexPath)
    }
    
}
extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
