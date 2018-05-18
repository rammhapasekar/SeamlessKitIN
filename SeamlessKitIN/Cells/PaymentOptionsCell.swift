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

let gutterSpace: CGFloat = 8.0
let viewSeparatorSpace: CGFloat = 12.0

class PaymentOptionsCell: UICollectionViewCell {
    
    
    lazy var headingLbl: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.borderWidth = 0
        label.borderColor = UIColor.white
        label.text = "Credit Card"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = ApplicationColors.TEXTCOLOR
        label.numberOfLines = 0
        return label
    }()
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bank-card-front-side")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        self.contentView.addSubview(headingLbl)
        self.contentView.addSubview(iconImageView)
        
        iconImageView.anchor(self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: 0, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
        
        headingLbl.anchor(iconImageView.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, topConstant: viewSeparatorSpace, leftConstant: gutterSpace, bottomConstant: viewSeparatorSpace, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
    }
}
