//
//  MyCollectionViewCell.swift
//  MyCollectionApp
//
//  Created by Panachai Sulsaksakul on 6/24/24.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
//    @IBOutlet var textDescription: UILabel!
    
    static var identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: Girl) {
        self.imageView.image = UIImage(named: model.name)
//        self.textDescription.text = model.description
        
    }
    
}
