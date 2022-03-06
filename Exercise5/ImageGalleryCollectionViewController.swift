//
//  ImageGalleryCollectionViewController.swift
//  Exercise5
//
//  Created by Oren Dinur on 02/03/2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageGalleryCollectionViewController: UICollectionViewController {
    
//    //Start of Model
//    var NASA: Dictionary<String,URL> = {
//       let NASAURLStrings = [
//           "Cassini" : "https://www.w3schools.com/images/w3schools_green.jpg",
//           "Earth" : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AEarth_Western_Hemisphere.jpg&psig=AOvVaw2FrZFSEfEHPvSJsen8dB9i&ust=1646140999673000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCOjV6Z6_ovYCFQAAAAAdAAAAABAD",
//           "Saturn" : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ALatest_Saturn_Portrait_(48725935576).jpg&psig=AOvVaw0uPnD0FEusmhTNeIGxOEMq&ust=1646141017109000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCMCHpKi_ovYCFQAAAAAdAAAAABAD"
//       ]
//       var urls = Dictionary<String,URL>()
//       for (key,value) in NASAURLStrings {
//           urls[key] = URL(string: value)
//       }
//       return urls
//   }()
    //// End Of Model
    ///////
    
    
    
//    var imageURL: URL? {
//        didSet {
//            image = nil
//            if view.window != nil { //Am I on screen?
//                fetchImage()
//            }
//        }
//    }
    
    ///////
    ///
    ///
    
    var allImagesWidth = 250
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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

    var cassiniURLs = [ "https://ichef.bbci.co.uk/news/976/cpsprodpb/17419/production/_97775259_saturn.jpg",
         "https://cdn.vox-cdn.com/thumbor/S_2OnmKwFbURIsaY5R0gGR1B6Pk=/0x0:3000x2000/620x413/filters:focal(1300x741:1780x1221):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/56671157/cassini.0.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLGheJOf1gtzua1PYb_Qnq5OWkaoaiMhdP3Q&usqp=CAU",
            "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2004/06/saturn_orbit_insertion_manoeuvre2/17885286-2-eng-GB/Saturn_orbit_insertion_manoeuvre.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJqmNdNdMDERRQZALWMNmZpFFXpJ5fRbjKAA&usqp=CAU"
    ]
    

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        return NASA["Cassini"].count
        return cassiniURLs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        // Configure the cell
        if let imageCell = cell as? ImageCollectionViewCell {
            if let url = URL(string: cassiniURLs[indexPath.item])?.imageURL {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let urlContents = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let imageData = urlContents {
                            let imageView = UIImageView()
                            imageView.image = UIImage(data: imageData)
                            let imgHeight = imageView.image?.size.height
                            let imgWidth = imageView.image?.size.width
                            
                            imageView.sizeToFit()
                            imageCell.addSubview(imageView)
                        }
                    }
                }
            }
            
        }
        
        return cell
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
