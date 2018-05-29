//
//  SavedCardsCell.swift
//  SeamlessKitIN
//
//  Created by Ram Mhapasekar on 5/25/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

class SavedCardsCell: UITableViewCell {
    //MARK: Variables
    var iconImgConstraints = [NSLayoutConstraint]()
    
    //MARK:
    //MARK:Views

    lazy var cardNumberLbl: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.blue
        label.borderWidth = 0
        label.borderColor = UIColor.black
        label.text = "MasterCard ****2354"
        label.textColor = ApplicationColors.TEXTCOLOR_DARK
        label.font = ApplicationFonts.SYSTEM_MEDIUM_15
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let cardIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.backgroundColor = UIColor.blue
        imageView.tintColor = ApplicationColors.TEXTCOLOR_DARK
        return imageView
    }()
    
    let radioBtnImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.backgroundColor = UIColor.blue
        imageView.tintColor = ApplicationColors.TEXTCOLOR_DARK
        return imageView
    }()
    
    lazy var cvvBtn: UIButtonX = {
        let button = UIButtonX()
        button.backgroundColor = UIColor.blue
        button.borderColor = UIColor.clear
        button.borderWidth = 0
        button.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleAttributes = [
            NSAttributedStringKey.font : ApplicationFonts.SYSTEM_BOLD_15,
            NSAttributedStringKey.foregroundColor : ApplicationColors.SELECTION_COLOR]
        let attributeString = NSMutableAttributedString(string: "What is CVV",
                                                        attributes: titleAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        return button
    }()
    
    lazy var cvvTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter CVV".trimmingCharacters(in: .whitespacesAndNewlines)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = ApplicationColors.BORDER_COLOR.cgColor
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.cornerRadius = 5
        return textField
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        print("Save card selected state")
        if selected{
            self.contentView.backgroundColor = UIColor.white
        }
        else{
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        contentView.addSubview(cardIconImageView)
        contentView.addSubview(cardNumberLbl)
        contentView.addSubview(radioBtnImageView)
        contentView.addSubview(cvvTextField)
        contentView.addSubview(cvvBtn)
        
        iconImgConstraints = cardIconImageView.anchorWithReturnAnchors(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: gutterSpace, rightConstant: 0, widthConstant: 50, heightConstant: 40)
        
        _ = cardNumberLbl.anchorWithReturnAnchors(cardIconImageView.topAnchor, left: cardIconImageView.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: gutterSpace, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = radioBtnImageView.anchorWithReturnAnchors(cardIconImageView.topAnchor, left: cardNumberLbl.rightAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 5, leftConstant: gutterSpace, bottomConstant: 0, rightConstant: gutterSpace, widthConstant: 25, heightConstant: 25)
        
        _ = cvvTextField.anchorWithReturnAnchors(cardIconImageView.bottomAnchor, left: cardNumberLbl.leftAnchor, bottom: contentView.bottomAnchor, right: nil, topConstant: gutterSpace, leftConstant: 0, bottomConstant: gutterSpace, rightConstant: 0, widthConstant: 100, heightConstant: 40)
        
        _ = cvvBtn.anchorWithReturnAnchors(cardIconImageView.bottomAnchor, left: cvvTextField.rightAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: viewSeparatorSpace, leftConstant: gutterSpace, bottomConstant: 0, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 40)
    }
    
    fileprivate func removeViews(){
        cvvTextField.removeFromSuperview()
        cvvBtn.removeFromSuperview()
    }
}
