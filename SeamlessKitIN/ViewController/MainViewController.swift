//
//  MainViewController.swift
//  SeamlessKitIN
//
//  Created by Ram Mhapasekar on 5/18/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

let viewWidth = UIScreen.main.bounds.width
let viewHeight = UIScreen.main.bounds.height
let gutterSpace: CGFloat = 8.0
let viewSeparatorSpace: CGFloat = 12.0
var numberOfItems = 9

class MainViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,PromotionViewDelegate {
    
    
    //MARK: Variables
    let cellId = "PaymentOptionsCell"
    
    var collectionViewConstraints = [NSLayoutConstraint]()
    
    //MARK:
    //MARK:: Views
    
    let headerView: UIViewX = {
        let view = UIViewX()
        view.backgroundColor = ApplicationColors.HEADINGCOLOR
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = ApplicationColors.TEXTCOLOR
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    lazy var orderAmtLbl: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.borderWidth = 0
        label.borderColor = UIColor.black
        label.text = "\u{20B9} 2000.0"
        label.textColor = ApplicationColors.TEXTCOLOR
        label.font = ApplicationFonts.SYSTEM_BOLD_15
        label.numberOfLines = 0
        return label
    }()
    
    lazy var orderRefNumber: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.borderWidth = 0
        label.borderColor = UIColor.black
        label.text = "Order#: 1234567890123456789012345"
        label.textColor = ApplicationColors.TEXTCOLOR
        label.font = ApplicationFonts.SYSTEM_REG_13
        label.numberOfLines = 0
        return label
    }()
    
    lazy var collectionView: UICollectionView =
        {
            let layout = GridLayout()
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .white
            cv.delegate = self
            cv.dataSource = self
            cv.register(PaymentOptionsCell.self, forCellWithReuseIdentifier: cellId)
            cv.showsHorizontalScrollIndicator = true
            cv.alwaysBounceHorizontal = true
            cv.showsVerticalScrollIndicator = false
            cv.indicatorStyle = UIScrollViewIndicatorStyle.default
            return cv
    }()
    
    lazy var plusBtn: UIButtonX = {
        let button = UIButtonX()
        button.backgroundColor = ApplicationColors.BUTTONCOLOR
        button.borderColor = ApplicationColors.BUTTONCOLOR
        button.borderWidth = 0
        button.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleAttributes = [
            NSAttributedStringKey.font : ApplicationFonts.SYSTEM_BOLD_15,
            NSAttributedStringKey.foregroundColor : UIColor.white]
        let attributeString = NSMutableAttributedString(string: "+",
                                                        attributes: titleAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(plusBtnClick), for: .touchUpInside)
        return button
    }()
    
    lazy var numberOfItemsCount: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.borderWidth = 0
        label.borderColor = UIColor.black
        label.text = "\(numberOfItems)"
        label.textColor = UIColor.black
        label.font = ApplicationFonts.SYSTEM_REG_13
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var minusBtn: UIButtonX = {
        let button = UIButtonX()
        button.backgroundColor = ApplicationColors.BUTTONCOLOR
        button.borderColor = ApplicationColors.BUTTONCOLOR
        button.borderWidth = 0
        button.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleAttributes = [
            NSAttributedStringKey.font : ApplicationFonts.SYSTEM_BOLD_15,
            NSAttributedStringKey.foregroundColor : UIColor.white]
        let attributeString = NSMutableAttributedString(string: "-",
                                                        attributes: titleAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(minusBtnClick), for: .touchUpInside)
        return button
    }()
    
    lazy var promotionBtn: UIButtonX = {
        let button = UIButtonX()
        button.backgroundColor = ApplicationColors.BUTTONCOLOR
        button.borderColor = ApplicationColors.BUTTONCOLOR
        button.borderWidth = 0
        button.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleAttributes = [
            NSAttributedStringKey.font : ApplicationFonts.SYSTEM_BOLD_15,
            NSAttributedStringKey.foregroundColor : UIColor.white]
        let attributeString = NSMutableAttributedString(string: "PROMOTION",
                                                        attributes: titleAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(displayPromotions), for: .touchUpInside)
        return button
    }()
    
    
    //MARK:
    //MARK:: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ApplicationColors.BACKGROUNDCOLOR
        print("Into MainViewController")
        setupViews()
//        addSwipeGesture()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func addSwipeGesture(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(displayPromotions))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.promotionBtn.addGestureRecognizer(swipeUp)
    }
    
    fileprivate func setupViews(){
        collectionView.removeConstraints(collectionViewConstraints)
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.setCollectionViewLayout(GridLayout(), animated: false)
        
        self.view.addSubview(headerView)
        headerView.addSubview(iconImageView)
        headerView.addSubview(orderAmtLbl)
        headerView.addSubview(orderRefNumber)
        self.view.addSubview(collectionView)
        self.view.addSubview(minusBtn)
        self.view.addSubview(numberOfItemsCount)
        self.view.addSubview(plusBtn)
        self.view.addSubview(promotionBtn)
        
        headerView.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        iconImageView.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: nil, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: gutterSpace, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        orderAmtLbl.anchor(iconImageView.topAnchor, left: iconImageView.rightAnchor, bottom: nil, right: headerView.rightAnchor, topConstant: viewSeparatorSpace, leftConstant: viewSeparatorSpace, bottomConstant: 0, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
        
        orderRefNumber.anchor(orderAmtLbl.bottomAnchor, left: iconImageView.rightAnchor, bottom: nil, right: headerView.rightAnchor, topConstant: 5, leftConstant: viewSeparatorSpace, bottomConstant: 0, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
        
        let itemHeight = GridLayout().itemHeight()
        if numberOfItems <= 5
        {
            collectionViewConstraints = collectionView.anchorWithReturnAnchors(headerView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: itemHeight)
        }
        else{
            collectionViewConstraints = collectionView.anchorWithReturnAnchors(headerView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: itemHeight*2)
        }
        
        minusBtn.anchor(collectionView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        numberOfItemsCount.anchor(minusBtn.topAnchor, left: minusBtn.rightAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        plusBtn.anchor(minusBtn.topAnchor, left: numberOfItemsCount.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
         numberOfItemsCount.text = "\(numberOfItems)"
        
        promotionBtn.anchor(nil, left: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: viewWidth-40, heightConstant: 40)
        promotionBtn.anchorCenterXToSuperview(constant: 0)
    }

    
    @objc func plusBtnClick(){
        numberOfItems += 1
        collectionView.reloadData()
        setupViews()
    }
    
    @objc func minusBtnClick(){
        numberOfItems -= 1
        collectionView.reloadData()
        setupViews()
    }
    
    //MARK:
    //MARK: CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PaymentOptionsCell else {
            fatalError("Unexpected CollectionView Cell")
        }
        cell.headingLbl.text = "Option# \(indexPath.item)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection View cell click at :: \(indexPath.item)")
    }
    
    @objc fileprivate func displayPromotions(){
        let vc = PromotionViewController()
        vc.promotionDelegate = self
        self.presentpopupViewController(popupViewController: vc, animationType: .BottomBottom, completion:  { () -> Void in })
    }
    
    //MARK:
    //MARK:: PromotionViewDelegate Methods
    
    func dismissView(sender: PromotionViewController) {
        self.dismissPopupViewController(animationType: .BottomBottom)
    }
}
