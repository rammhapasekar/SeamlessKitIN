//
//  PaymentOptionsCell.swift
//  SeamlessKitIN
//
//  Created by Ram Mhapasekar on 5/18/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

/**
 Output :: CollectionViewCell which contains one imageView and label
 */

class PaymentOptionsCell: UICollectionViewCell {
    
    lazy var headingLbl: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.borderWidth = 0
        label.borderColor = UIColor.black
        label.text = "Credit Card"
        label.textColor = UIColor.black
        label.font = ApplicationFonts.SYSTEM_REG_13
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bank-card-front-side")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.contentView.layer.borderWidth = 0.75
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.cornerRadius = 2
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.contentView.bounds
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor]
//        self.contentView.layer.addSublayer(gradientLayer)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        
        self.contentView.addSubview(headingLbl)
        self.contentView.addSubview(iconImageView)
        
        iconImageView.anchor(self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: 0, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
        
        headingLbl.anchor(iconImageView.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: 5, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
        headingLbl.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
    }
}
