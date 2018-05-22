//
//  PromotionViewController.swift
//  SeamlessKitIN
//
//  Created by Ram Mhapasekar on 5/22/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

protocol PromotionViewDelegate:class{
    func dismissView(sender: PromotionViewController)
}

class PromotionViewController: UIViewController {

    //MARK:: Variables
    weak var promotionDelegate: PromotionViewDelegate?
    
    //MARK:
    //MARK:: Views
    lazy var dismissBtn: UIButtonX = {
        let button = UIButtonX()
        button.backgroundColor = ApplicationColors.BUTTONCOLOR
        button.borderColor = ApplicationColors.BUTTONCOLOR
        button.borderWidth = 0
        button.cornerRadius = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleAttributes = [
            NSAttributedStringKey.font : ApplicationFonts.SYSTEM_BOLD_15,
            NSAttributedStringKey.foregroundColor : UIColor.white]
        let attributeString = NSMutableAttributedString(string: "Dismiss Promotion VC",
                                                        attributes: titleAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(dismissBtnClick), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 20, y: 50, width: viewWidth-40, height: viewHeight-80)
        self.view.backgroundColor = ApplicationColors.BACKGROUNDCOLOR
        setupVC()
        addSwipeGesture()
    }
    
    fileprivate func addSwipeGesture(){
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissBtnClick))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    fileprivate func setupVC(){
        self.view.addSubview(dismissBtn)
        dismissBtn.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 100, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 250, heightConstant: 40)
        dismissBtn.anchorCenterXToSuperview(constant: 0)
    }
    
    @objc fileprivate func dismissBtnClick(){
        self.promotionDelegate?.dismissView(sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
