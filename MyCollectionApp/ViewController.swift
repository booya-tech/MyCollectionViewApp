//
//  ViewController.swift
//  MyCollectionApp
//
//  Created by Panachai Sulsaksakul on 6/21/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var collectionViewCircle: UICollectionView!
    
    var models: [Girl] = [
        Girl(name: "image_1", description: "My name is Jennie!"),
        Girl(name: "image_2", description: "My name is Jennie1!"),
        Girl(name: "image_3", description: "My name is Jennie2!"),
        Girl(name: "image_1", description: "My name is Jennie!"),
        Girl(name: "image_2", description: "My name is Jennie1!"),
        Girl(name: "image_3", description: "My name is Jennie2!"),
        Girl(name: "image_1", description: "My name is Jennie!"),
        Girl(name: "image_2", description: "My name is Jennie1!"),
        Girl(name: "image_3", description: "My name is Jennie2!"),
        Girl(name: "image_1", description: "My name is Jennie!"),
        Girl(name: "image_2", description: "My name is Jennie1!"),
        Girl(name: "image_3", description: "My name is Jennie2!"),
        Girl(name: "image_1", description: "My name is Jennie!"),
        Girl(name: "image_2", description: "My name is Jennie1!"),
        Girl(name: "image_3", description: "My name is Jennie2!")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
            cell.configure(with: models[indexPath.row])
            return cell
        } else if collectionView.tag == 2 {
            let cell = collectionViewCircle.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
            cell.configure(with: models[indexPath.row])
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

struct Girl {
    var name: String
    var description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
