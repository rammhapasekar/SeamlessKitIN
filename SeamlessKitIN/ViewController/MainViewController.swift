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
    let commonCellId = "commonCell"
    
    var paymentOptionCollectionViewConstraints = [NSLayoutConstraint]()
    
    //MARK:
    //MARK:: Views
    
    let headerView: UIViewX = {
        let view = UIViewX()
//        view.backgroundColor = ApplicationColors.HEADINGCOLOR
        view.firstColor = ApplicationColors.HEADINGCOLOR
        view.secondColor = ApplicationColors.HEADINGCOLOR
        return view
    }()
    
    lazy var backBtn: UIButtonX = {
        let button = UIButtonX()
        button.backgroundColor = UIColor.clear
        button.borderColor = UIColor.clear
        button.borderWidth = 0
        button.cornerRadius = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "back_btn").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = ApplicationColors.HEADING_TEXTCOLOR
//        button.imageView?.tintColor = ApplicationColors.HEADINGCOLOR
        button.addTarget(self, action: #selector(minusBtnClick), for: .touchUpInside)
        return button
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "company_logo")
        imageView.tintColor = ApplicationColors.HEADING_TEXTCOLOR
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
        label.textColor = ApplicationColors.HEADING_TEXTCOLOR
        label.font = ApplicationFonts.SYSTEM_BOLD_20
        label.numberOfLines = 0
        return label
    }()
    
    lazy var orderRefNumber: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.borderWidth = 0
        label.borderColor = UIColor.black
        label.text = "Order ID : 12345678901234567890"
        label.textColor = ApplicationColors.HEADING_TEXTCOLOR
        label.font = ApplicationFonts.SYSTEM_REG_15
        label.numberOfLines = 0
        return label
    }()
    
    lazy var paymentOptionsCollectionView: UICollectionView =
        {
            let layout = PaymentOptionGridLayout()
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .white
            cv.delegate = self
            cv.dataSource = self
            cv.register(PaymentOptionsCell.self, forCellWithReuseIdentifier: cellId)
            cv.showsHorizontalScrollIndicator = true
            cv.alwaysBounceHorizontal = true
            cv.showsVerticalScrollIndicator = false
            cv.indicatorStyle = UIScrollViewIndicatorStyle.white
            return cv
    }()
    
    // ---------- Net Banking Views
    
    let netBankingView: UIViewX = {
        let view = UIViewX()
        view.backgroundColor = UIColor.white
        //view.firstColor = ApplicationColors.HEADINGCOLOR
        //view.secondColor = ApplicationColors.HEADINGCOLOR
        return view
    }()
    
    lazy var netBankingCollectionView: UICollectionView =
        {
            let layout = GridLayout()
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .white
            cv.delegate = self
            cv.dataSource = self
            cv.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: commonCellId)
            cv.showsHorizontalScrollIndicator = true
            cv.showsVerticalScrollIndicator = false
            cv.indicatorStyle = UIScrollViewIndicatorStyle.white
            return cv
    }()
    
    lazy var otherBanksLabel: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.borderWidth = 0
        label.borderColor = UIColor.black
        label.text = "All Other Banks"
        label.textColor = ApplicationColors.TEXTCOLOR_DARK
        label.font = ApplicationFonts.SYSTEM_BOLD_15
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var bankNameTextField : UITextField = {
        var textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.placeholder = "Select Bank"
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.lightGray.cgColor
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 4.0
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        return textField
    }()
    
    lazy var noteLabel: UILabelX = {
        let label = UILabelX()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.borderWidth = 0
        label.textAlignment = NSTextAlignment.left
        label.borderColor = UIColor.black
        label.text = "Note: We will redirect you to the bank you have chosen above. Once the bank verifies your net banking credentials, we will proceed with your payment."
        label.textColor = ApplicationColors.TEXTCOLOR_DARK
        label.font = ApplicationFonts.SYSTEM_REG_13
        label.textColor = .black
        //label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var payFromNetBankingButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ApplicationColors.BUTTONCOLOR
        //let buttonTitleStr = NSMutableAttributedString(string:"Pay INR gutterSpace0.00", attributes:[NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: ApplicationFonts.SYSTEM_BOLD_15])
        //button.setAttributedTitle(buttonTitleStr, for: .normal)
        button.setTitle("Pay \u{20B9} 100.00", for: .normal)
        button.layer.cornerRadius = 5;
        button.tag = 112
        button.addTarget(self, action: #selector(confirmRefundBtnPressed(sender:)), for: .touchUpInside)
        return button
    }()
    // ---------- Net Banking Views End
    
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
        button.shadowColor = UIColor.black
        button.shadowRadius = 5
        button.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(displayPromotions), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK:
    //MARK:: confirmRefundBtnPressed Methods
    
    @objc func confirmRefundBtnPressed(sender: UIButton!)
    {
        print("Pay button clicked !!!")
    }
    
    
    //MARK:
    //MARK:: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white//ApplicationColors.BACKGROUNDCOLOR
        print("Into MainViewController")
        setupViews()
        
        addSwipeGesture()
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
    
    /**
     Method- setupViews
     The job of this method is to add and align all the views in the superView
     */
    fileprivate func setupViews(){
        paymentOptionsCollectionView.removeConstraints(paymentOptionCollectionViewConstraints)
        self.paymentOptionsCollectionView.collectionViewLayout.invalidateLayout()
        self.paymentOptionsCollectionView.setCollectionViewLayout(PaymentOptionGridLayout(), animated: false)
        self.netBankingCollectionView.setCollectionViewLayout(GridLayout(), animated: false)
        
        self.view.addSubview(headerView)
        headerView.addSubview(backBtn)
        headerView.addSubview(iconImageView)
        headerView.addSubview(orderAmtLbl)
        headerView.addSubview(orderRefNumber)
        self.view.addSubview(paymentOptionsCollectionView)
        
        
//        self.view.addSubview(minusBtn)
//        self.view.addSubview(numberOfItemsCount)
//        self.view.addSubview(plusBtn)
        self.view.addSubview(promotionBtn)
        
        headerView.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        backBtn.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        
        iconImageView.anchor(backBtn.bottomAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: nil, topConstant: gutterSpace, leftConstant: gutterSpace, bottomConstant: gutterSpace, rightConstant: 0, widthConstant: 70, heightConstant: 70)
        
        orderAmtLbl.anchor(iconImageView.topAnchor, left: iconImageView.rightAnchor, bottom: nil, right: headerView.rightAnchor, topConstant: viewSeparatorSpace, leftConstant: viewSeparatorSpace, bottomConstant: 0, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
        
        orderRefNumber.anchor(orderAmtLbl.bottomAnchor, left: iconImageView.rightAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, topConstant: 5, leftConstant: viewSeparatorSpace, bottomConstant: viewSeparatorSpace, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
        
        let itemHeight = PaymentOptionGridLayout().itemHeight()
        
//        if numberOfItems <= 5
//        {
            paymentOptionCollectionViewConstraints = paymentOptionsCollectionView.anchorWithReturnAnchors(headerView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: itemHeight+gutterSpace)
        
        
        
//        }
//        else{
//            collectionViewConstraints = collectionView.anchorWithReturnAnchors(headerView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: itemHeight*2)
//        }
        
//        minusBtn.anchor(collectionView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
//
//        numberOfItemsCount.anchor(minusBtn.topAnchor, left: minusBtn.rightAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//
//        plusBtn.anchor(minusBtn.topAnchor, left: numberOfItemsCount.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
//
//         numberOfItemsCount.text = "\(numberOfItems)"
        
        promotionBtn.anchor(nil, left: nil, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: viewWidth-24, heightConstant: 50)
        promotionBtn.anchorCenterXToSuperview(constant: 0)
    }
    
    //MARK:
    //MARK: Setup Net Banking View Method
    
    fileprivate func setupNetBankingView()
    {
        self.view.addSubview(netBankingView)
        netBankingView.addSubview(netBankingCollectionView)
        netBankingView.addSubview(otherBanksLabel)
        netBankingView.addSubview(bankNameTextField)
        netBankingView.addSubview(noteLabel)
        netBankingView.addSubview(payFromNetBankingButton)
        
        let commonitemHeight = GridLayout().itemHeight()
        
        netBankingView.anchor(paymentOptionsCollectionView.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: gutterSpace, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        netBankingCollectionView.anchor(netBankingView.topAnchor, left: netBankingView.leftAnchor, bottom: nil, right: netBankingView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: (commonitemHeight*2)+40)
        
        otherBanksLabel.anchor(netBankingCollectionView.bottomAnchor, left: netBankingView.leftAnchor, bottom: nil, right: netBankingView.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        bankNameTextField.anchor(otherBanksLabel.bottomAnchor, left: netBankingView.leftAnchor, bottom: nil, right: netBankingView.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 30)
        
        noteLabel.anchor(bankNameTextField.bottomAnchor, left: netBankingView.leftAnchor, bottom: nil, right: netBankingView.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        payFromNetBankingButton.anchor(noteLabel.bottomAnchor, left: netBankingView.leftAnchor, bottom: netBankingView.bottomAnchor, right: netBankingView.rightAnchor, topConstant: 20, leftConstant: gutterSpace, bottomConstant: gutterSpace, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 45)
        
    }

    
    @objc func plusBtnClick(){
        numberOfItems += 1
        paymentOptionsCollectionView.reloadData()
        setupViews()
    }
    
    @objc func minusBtnClick(){
//        numberOfItems -= 1
//        paymentOptionsCollectionView.reloadData()
//        setupViews()
    }
    
    //MARK:
    //MARK: CollectionView Methods
    /**
     The following methods are delegate and dataSource methods of CollectionView which are we implementing here, the job of this method is to collect the data of how many items are there in the section, the display of the custom collectionViewCell (ie. PaymentOptionsCell) and the handling of the cell selection
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == paymentOptionsCollectionView)
        {
            return numberOfItems
        }
        else if (collectionView == netBankingCollectionView)
        {
            return 6
        }
        else
        {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == paymentOptionsCollectionView)
        {
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PaymentOptionsCell else {
                fatalError("Unexpected CollectionView Cell")
            }
            cell.headingLbl.text = "Option# \(indexPath.item)"
            cell.iconImageView.image = UIImage(named: "icon\(indexPath.item)")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) ??  #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            //cell.selectionImageView.image = UIImage(named: "test")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) ??  #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            return cell
        }
            
        else
        {
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commonCellId, for: indexPath) as? CommonCollectionViewCell else {
                fatalError("Unexpected CollectionView Cell")
            }
            //cell.headingLbl.text = "Option# \(indexPath.item)"
            cell.iconImageView.image = UIImage(named: "bank\(indexPath.item)") ??  #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            cell.selectionImageView.image = UIImage(named: "test")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) ??  #imageLiteral(resourceName: "bank-card-front-side").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection View cell click at :: \(indexPath.item)")
        
        if (indexPath.item == 1)
        {
            setupNetBankingView()
        }
        else
        {
            netBankingView.removeFromSuperview()
        }
    }
    
    /**
     Method - displayPromotions
     1) In this method we will create an object of PromotionViewController class and pass that object to the presentpopupViewController with animation type .BottomBottom, which will present the view from the bottom of the display
     2) also we will hook-up the delegate object of PromotionViewDelegate with the ViewController for the further communication between the VC
     */
    @objc fileprivate func displayPromotions(){
        let vc = PromotionViewController()
        vc.promotionDelegate = self
        self.presentpopupViewController(popupViewController: vc, animationType: .BottomBottom, completion:  { () -> Void in })
    }
    
    //MARK:
    //MARK:: PromotionViewDelegate Methods
    /**
     Method- dismissView(sender:)
     we are defining this protocol method here, the job of this method is to dismiss PromotionViewController from the view hierarchy
     */
    func dismissView(sender: PromotionViewController) {
        self.dismissPopupViewController(animationType: .BottomBottom)
    }
}
