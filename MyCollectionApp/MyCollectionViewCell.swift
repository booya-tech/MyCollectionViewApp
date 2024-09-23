//
//  MyCollectionViewCell.swift
//  MyCollectionApp
//
//  Created by Panachai Sulsaksakul on 6/24/24.
//

import UIKit
import SDWebImage

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    static var identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.contentMode = .scaleAspectFill
    }
    
    public func configure(with photo: Photo) {
        if let imageUrl = photo.imageURLs.first {
            imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
    }
    
}
