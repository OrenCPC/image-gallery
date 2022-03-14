//
//  ImageGalleryCollectionViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

class ImageGalleryCollectionViewController: UICollectionViewController
, UICollectionViewDelegateFlowLayout{
    
    var downloadedImages = Array<Photo>()
    
    private lazy var imageGalleryModel = ImageGallery()
    
    private var width: CGFloat = 300
        
    
//    var flowLayout: UICollectionViewFlowLayout? {
//    return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
//    }
    
    @objc func adjustImagesScale(byHandlingGestureRecognizedBy recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            self.width *= recognizer.scale
            recognizer.scale = 1.0
            print("width \(width)")
//            flowLayout?.invalidateLayout()
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
        imageGalleryModel.getImages(galleryName: galleryName!) {images in
            downloadedImages = images
        }
        updateCollectionView()
    }
    
    var galleryName: String?{
        didSet {
            print(galleryName)
            updateViewFromModel()
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.

//        updateViewFromModel()
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(adjustImagesScale(byHandlingGestureRecognizedBy:)))
        collectionView?.addGestureRecognizer(pinch)
        
        }

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    func ratio(at indexPath: IndexPath) -> CGFloat {
        return downloadedImages[indexPath.item].ratio
    }

    func image(at indexPath: IndexPath) -> UIImage {
        return downloadedImages[indexPath.item].image
    }

    func calculatedSize(at indexPath: IndexPath)-> CGSize {
        let height = self.width / ratio(at: indexPath)
        return CGSize(width: self.width, height: height)
    }

    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedImages.count
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
