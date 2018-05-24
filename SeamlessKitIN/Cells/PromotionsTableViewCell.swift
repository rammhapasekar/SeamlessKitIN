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
        label.font = ApplicationFonts.SYSTEM_BOLD_13
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
            NSAttributedStringKey.font : ApplicationFonts.SYSTEM_LIGHT_13,
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
        
        setupView()
    }
    
    private func setupView()
    {
        contentView.addSubview(promotionTitleLabel)
        contentView.addSubview(promotionDescriptionLabel)
        contentView.addSubview(applyPromotionButton)
        
        let views: [String: Any] = ["promotionTitleLabel" : promotionTitleLabel,
                                    "promotionDescriptionLabel" : promotionDescriptionLabel,
                                    "applyPromotionButton" : applyPromotionButton]
        
        let matrics = ["gutterValue" : 10]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(gutterValue)-[promotionTitleLabel]-[applyPromotionButton(==50)]-(gutterValue)-|", options: .alignAllFirstBaseline, metrics: matrics, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(gutterValue)-[promotionDescriptionLabel]-(gutterValue)-|", options: .alignAllFirstBaseline, metrics: matrics, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[promotionTitleLabel]-[promotionDescriptionLabel]-|", options: [], metrics: nil, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[applyPromotionButton(==23)]-[promotionDescriptionLabel]-|", options: [], metrics: nil, views: views))
        
        promotionTitleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: UILayoutConstraintAxis.horizontal)
        
        promotionDescriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: UILayoutConstraintAxis.vertical)
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
