//
//  ImageGalleryCollectionViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

class ImageGalleryCollectionViewController: UICollectionViewController
, UICollectionViewDelegateFlowLayout{
    
//    private let reuseIdentifier = "Cell"
    
    private var images: [Photo] = []
    private var imagesURL: [URL?] = []
    
    private var width: CGFloat = 200 {
        didSet {
            
        }
    }
    
    private func updateCollectionView () {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func fetchImage(imageUrl: URL?) {
        if let url = imageUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents {
                    if let image = UIImage(data: imageData) {
                        let imageWidth = image.size.width
                        let imageHeight = image.size.height
                        self?.images += [Photo(image: image, ratio: imageWidth/imageHeight)]
                        self?.updateCollectionView()
                    }
                }
            }
        }
    }
    
    private func startFetch() {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        
        for index in 0..<imagesURL.count {
            let op1 = BlockOperation(block: {
                self.fetchImage(imageUrl: self.imagesURL[index]!)
            })
            
            queue.addOperation(op1)
        }
        
        queue.waitUntilAllOperationsAreFinished()
        
        updateCollectionView()
    }
    
//    private func startFetch() {
//
//        let kMaxConcurrent = 3 // Or 1 if you want strictly ordered downloads!
//        let semaphore = DispatchSemaphore(value: kMaxConcurrent)
//        let downloadQueue = DispatchQueue(label: "com.app.downloadQueue", attributes: .concurrent)
//
//
////        imagesURL = cassiniURLs.compactMap{ URL(string: $0) }
//
//
//        for index in 0..<imagesURL.count {
//            downloadQueue.async { [unowned self] in
//                semaphore.wait()
//                self.fetchImage(imageUrl: self.imagesURL[index]!)
//                semaphore.signal()
//            }
//        }
////        waitUntilAllOperationsAreFinished()
//
//    }
    
    ///
    ///
    ///
    ///
    ///
//    let queue = OperationQueue()
//    queue.maxConcurrentOperationCount = 3
//
//    let op1 = BlockOperation(block: {
//      print("implementing op1")
//    })
//    queue.addOperation(op1)
//    queue.waitUntilAllOperationsAreFinished()

    
    
    ////
    ///
    ///
    ///
    ///
    
    
    
                                               
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
        imagesURL = cassiniURLs.compactMap{ URL(string: $0) }
        startFetch()
//        model = imageGalleryModel(urls: cassiniURLs.compactMap{ URL(string: $0) })
        
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

    
    var cassiniURLs = [ "https://ichef.bbci.co.uk/news/976/cpsprodpb/17419/production/_97775259_saturn.jpg",
         "https://cdn.vox-cdn.com/thumbor/S_2OnmKwFbURIsaY5R0gGR1B6Pk=/0x0:3000x2000/620x413/filters:focal(1300x741:1780x1221):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/56671157/cassini.0.jpg"
                        ,
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLGheJOf1gtzua1PYb_Qnq5OWkaoaiMhdP3Q&usqp=CAU",
            "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2004/06/saturn_orbit_insertion_manoeuvre2/17885286-2-eng-GB/Saturn_orbit_insertion_manoeuvre.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJqmNdNdMDERRQZALWMNmZpFFXpJ5fRbjKAA&usqp=CAU"
    ]
    
//    func ratio(at indexPath: IndexPath) -> CGFloat {
//        return images[indexPath.item].ratio
//    }

//    func image(at indexPath: IndexPath) -> UIImage {
//        return images[indexPath.item].image
//    }

    func calculatedSize(at indexPath: IndexPath)-> CGSize {
        let height = self.width / images[indexPath.item].ratio
        
        return CGSize(width: self.width, height: height)
    }

    
    var flowLayout: UICollectionViewFlowLayout? {
    return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.image = images[indexPath.item].image.resizeImageTo(size: calculatedSize(at: indexPath))
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
