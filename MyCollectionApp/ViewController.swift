//
//  ViewController.swift
//  MyCollectionApp
//
//  Created by Panachai Sulsaksakul on 6/21/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var photoController = PhotoController()
    var photos: [Photo] = []
    
    @IBOutlet var collectionView: UICollectionView!
    var collectionViewCircle: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // MARK: - Networking

        // Test Alamofire
        photoController.fetchPhotos { (response) in
            switch response {
            case .success(let fetchedPhotos):
                self.photos = fetchedPhotos
//                print("photos: \(self.photos)")
                print("fetchPhotos: \(fetchedPhotos)")
            case .failure(let error):
                print("Error fetching photos: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionViewCircle.reloadData()
            }
        }
//        fetchPhotos()
        
    //    func fetchPhotos() {
    //        let url = "https://api.500px.com/v1/photos?feature=popular&page=1"
    //        let headers: HTTPHeaders = [
    //            "Authorization": "Bearer YOUR_OAUTH_TOKEN"
    //        ]
    //
    //        AF.request(url, headers: headers).responseDecodable(of: PhotosResponse.self) { response in
    //            switch response.result {
    //            case .success(let photosResponse):
    //                self.photos = photosResponse.photos
    //
    //                DispatchQueue.main.async {
    //                    self.collectionView.reloadData()
    //                    self.collectionViewCircle.reloadData()
    //                }
    //            case .failure(let error):
    //                print("Error fetching photos: \(error)")
    //            }
    //        }
    //    }
        
        // The first collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width / 3) - 1, height: (view.frame.size.width / 3) - 1)
        collectionView?.collectionViewLayout = layout
        
        // The second collection view layout (circle)
        let layoutCircle = UICollectionViewFlowLayout()
        layoutCircle.scrollDirection = .horizontal
        layoutCircle.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layoutCircle.itemSize = CGSize(width: 75, height: 75)
        collectionViewCircle = UICollectionView(frame: .zero, collectionViewLayout: layoutCircle)
        collectionViewCircle.showsHorizontalScrollIndicator = false
        
        // Ensure proper z-order by adding collectionViewCircle after collectionView
        view.addSubview(collectionView)
        view.addSubview(collectionViewCircle)
        
        // Register Collection Views
        collectionView?.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionViewCircle.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        
        // Register footer only for collectionView
        collectionView?.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        
        // Initialize the first collection view layout
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView.tag = 1
        
        // Initialize the second collection view layout (circle)
        collectionViewCircle?.delegate = self
        collectionViewCircle?.dataSource = self
        collectionViewCircle.tag = 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeArea = view.safeAreaInsets
        // Set the frame for collectionView
        collectionView.frame = CGRect(x: 0, y: safeArea.top + 100, width: view.frame.size.width, height: view.frame.size.height - safeArea.top - 100).integral
        // Set the frame for collectionViewCircle on top of collectionView
        collectionViewCircle.frame = CGRect(x: 0, y: safeArea.top, width: view.frame.size.width, height: 75).integral
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
            
            let photo = photos[indexPath.item]
            cell.configure(with: photo)
            return cell
        } else if collectionView.tag == 2 {
            let cell = collectionViewCircle.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
            
            let photo = photos[indexPath.item]
            cell.configure(with: photo)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: (view.frame.size.width / 3) - 1, height: (view.frame.size.width / 3) - 1)
        } else if collectionView.tag == 2 {
            return CGSize(width: 75, height: 75)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView.tag == 1 && kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as! FooterCollectionReusableView
            footer.configure()
            return footer
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: view.frame.size.width, height: 100)
        }
        return CGSize.zero
    }
}
