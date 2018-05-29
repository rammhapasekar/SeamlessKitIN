//
//  PromotionsTableViewCell.swift
//  SeamlessKitIN
//
//  Created by Mayur Shinde on 23/05/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

protocol PromotionViewDelegate1:class{
    func dismissView(sender: PromotionViewController)
}

class PromotionsTableViewCell: UITableViewCell
{    
    weak var promotionDelegate: PromotionViewDelegate1?

    lazy var promotionTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 0
        label.numberOfLines = 0
        label.font = ApplicationFonts.SYSTEM_BOLD_15
        label.textColor = ApplicationColors.HEADINGCOLOR
        
        return label
    }()
    
    lazy var promotionDescriptionLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 0
        label.numberOfLines = 0
        label.font = ApplicationFonts.SYSTEM_LIGHT_13
        label.textColor = UIColor.black
        
        return label
    }()
    
    lazy var applyPromotionButton: UIButtonX = {
        let button = UIButtonX()
        button.backgroundColor = ApplicationColors.BUTTONCOLOR
        button.borderColor = ApplicationColors.BUTTONCOLOR
        button.borderWidth = 0
        button.cornerRadius = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleAttributes = [
            NSAttributedStringKey.font : ApplicationFonts.SYSTEM_REG_15,
            NSAttributedStringKey.foregroundColor : UIColor.white]
        let attributeString = NSMutableAttributedString(string: "Apply",
                                                        attributes: titleAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(applyPromotionButtonClicked), for: .touchUpInside)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.red.cgColor//ApplicationColors.BORDER_COLOR.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setupView()
    }
    
    private func setupView()
    {
        contentView.addSubview(promotionTitleLabel)
        contentView.addSubview(promotionDescriptionLabel)
        contentView.addSubview(applyPromotionButton)
        
        promotionTitleLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: viewSeparatorSpace, leftConstant: gutterSpace, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        applyPromotionButton.anchor(contentView.topAnchor, left: promotionTitleLabel.rightAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: 0, rightConstant: gutterSpace, widthConstant: 60, heightConstant: 30)
        promotionDescriptionLabel.anchor(applyPromotionButton.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: gutterSpace, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
    }
    
    @objc fileprivate func applyPromotionButtonClicked()
    {
        print("Apply promotion clicked !!!")
    }

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }

}
