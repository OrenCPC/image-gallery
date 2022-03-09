//
//  ImageGalleryCollectionViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageGalleryCollectionViewController: UICollectionViewController
, UICollectionViewDelegateFlowLayout{
    
    
    
//    lazy private var model = imageGalleryModel(urls: cassiniURLs.compactMap{ URL(string: $0) }) {
//        didSet {
//            print("set model")
//            collectionView.reloadData()
//        }
//    }
    
//    func startFetch() {
//       model = imageGalleryModel(urls: cassiniURLs.compactMap{ URL(string: $0) })
//
//    }
    
    private func updateCollectionView () {
        downloadedImages += 1
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
                                    self?.images += [image]
                                    self?.imagesWidth += [imageWidth]
                                    self?.imagesHeight += [imageHeight]
                                self?.updateCollectionView()
                            }
                        }
                    
                }
            }
    }
        
    
    private func startFetch() {
        ///
        ///fetch all images in a multithreaded manner and when finished create collectionView
        ///
        
            imagesURL = cassiniURLs.compactMap{ URL(string: $0) }
            for index in 0..<imagesURL.count {
            fetchImage(imageUrl: imagesURL[index]!)
        }
    }
    

                                               
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return cassiniImage.count
//    }

//    var cassiniImage : URL = "www.w3schools.com/images/w3schools_green.jpg"
    

    //let url = URL(string: "https://www.avanderlee.com")!

    
    private var images: [UIImage?] = []
    private var imagesWidth: [CGFloat?] = []
    private var imagesHeight: [CGFloat?] = []
    private var imagesURL: [URL?] = []
    private var downloadedImages = 0
    
    
    
    
    var cassiniURLs = [ "https://ichef.bbci.co.uk/news/976/cpsprodpb/17419/production/_97775259_saturn.jpg"
                        
                        ,

         "https://cdn.vox-cdn.com/thumbor/S_2OnmKwFbURIsaY5R0gGR1B6Pk=/0x0:3000x2000/620x413/filters:focal(1300x741:1780x1221):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/56671157/cassini.0.jpg"
                        ,
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLGheJOf1gtzua1PYb_Qnq5OWkaoaiMhdP3Q&usqp=CAU",
            "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2004/06/saturn_orbit_insertion_manoeuvre2/17885286-2-eng-GB/Saturn_orbit_insertion_manoeuvre.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJqmNdNdMDERRQZALWMNmZpFFXpJ5fRbjKAA&usqp=CAU"
    ]
    
    
//    func imageURL(at indexPath: IndexPath) -> URL? {
//        return model.photos[indexPath.item].imageURL ?? nil
//    }
//
    func ratio(at indexPath: IndexPath) -> CGFloat? {
        return width(at: indexPath)! / height(at: indexPath)!
    }

    func image(at indexPath: IndexPath) -> UIImage? {
        return images[indexPath.item] ?? nil
    }
    
    func height(at indexPath: IndexPath) -> CGFloat? {
        return imagesHeight[indexPath.item] ?? nil
    }
    
    func width(at indexPath: IndexPath) -> CGFloat? {
        return imagesWidth[indexPath.item] ?? nil
    }
//
//    func didImageDownload(at indexPath: IndexPath) -> Bool {
//        return model.photos[indexPath.item].didDownloadImage
//    }
    
    
    private var allImagesWidth = 80.0
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        print("model.photos.count \(model.photos.count)")
//        return model.photos.count
        
        return downloadedImages
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        // Configure the cell
        if let imageCell = cell as? ImageCollectionViewCell {
            print("Trying to create a cell")
            imageCell.image = image(at: indexPath)
            
//            imageCell.imageURL = imageURL(at: indexPath)
//            imageCell.ratio = ratio(at: indexPath)
//            imageCell.image = image(at: indexPath)
        }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        var newHeight = height(at: indexPath)!
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell {
            if let ratio = ratio(at: indexPath) {
                newHeight = width(at: indexPath)! / ratio
            }
//        }
        
//        return CGSize(width: 300, height: 300)

    return CGSize(width: allImagesWidth, height: newHeight)

    }

    
    
//        let ratio =  imageCell.imageView.image?.size.width / imageCell.imageView.image?.size.height
//                let newHeight = imageCell.image?.size.width / ratio
//        let newHeight = 0
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
//        if let imageCell = cell as? ImageCollectionViewCell {
//           let width =  imageCell.imageView.image?.size.width
//            let height = imageCell.imageView.image?.size.height
//            let ratio = width / height
//            newHeight =  width/ratio
//        }


       
        

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

