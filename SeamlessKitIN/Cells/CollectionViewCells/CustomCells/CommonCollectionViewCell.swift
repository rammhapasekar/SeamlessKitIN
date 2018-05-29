//
//  CommonCollectionViewCell.swift
//  SeamlessKitIN
//
//  Created by Mayur Shinde on 25/05/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

class CommonCollectionViewCell: UICollectionViewCell
{
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0
        //imageView.layer.borderColor = UIColor.black.cgColor
        //imageView.tintColor = ApplicationColors.TEXTCOLOR_DARK
        return imageView
    }()
    
    let selectionImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0
        //imageView.layer.borderColor = UIColor.black.cgColor
        //imageView.tintColor = ApplicationColors.TEXTCOLOR_DARK
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.contentView.layer.borderWidth = 0.4
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.cornerRadius = 2
        self.contentView.backgroundColor = .white
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.contentView.bounds
        gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.white.cgColor]
        //        self.contentView.layer.addSublayer(gradientLayer)
        setupViews()
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                
            }
            else
            {
                
            }
        }
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews()
    {
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(selectionImageView)

        iconImageView.anchor(self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: nil, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: gutterSpace, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        selectionImageView.anchor(self.contentView.topAnchor, left: self.iconImageView.rightAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, topConstant: gutterSpace, leftConstant: 10, bottomConstant: gutterSpace, rightConstant: gutterSpace, widthConstant: 30, heightConstant: 30)
    }
}
