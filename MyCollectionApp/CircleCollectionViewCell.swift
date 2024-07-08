//
//  CircleCollectionViewCell.swift
//  MyCollectionApp
//
//  Created by Panachai Sulsaksakul on 6/23/24.
//

import UIKit
import SDWebImage

class CircleCollectionViewCell: UICollectionViewCell {
    static var identifier = "CircleCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 75.0 / 2.0
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
    
    public func configure(with photo: Photo) {
        if let imageUrl = photo.imageURLs.first {
            imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    

}
