//
//  CollectionReusableView.swift
//  MyCollectionApp
//
//  Created by Panachai Sulsaksakul on 6/21/24.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderCollectionReusableView"
    
    private let circleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 75.0 / 2.0
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        backgroundColor = .darkGray
        addSubview(circleImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleImage.frame = bounds
    }
    
}

class FooterCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "FooterCollectionReusableView"
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Hi, I'm footer of this Collection View"
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    public func configure() {
        backgroundColor = .white
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
}
