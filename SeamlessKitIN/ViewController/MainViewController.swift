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

class MainViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    //MARK: Variables
    let cellId = "PaymentOptionsCell"
    
    var collectionViewConstraints = [NSLayoutConstraint]()
    
    //MARK:
    //MARK:: Views
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
        return cv
    }()
    
    
    lazy var plusBtn: UIButtonX = {
        let button = UIButtonX()
        button.backgroundColor = ApplicationColors.TEXTCOLOR
        button.borderColor = ApplicationColors.TEXTCOLOR
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
        button.backgroundColor = ApplicationColors.TEXTCOLOR
        button.borderColor = ApplicationColors.TEXTCOLOR
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
    
    
    //MARK:
    //MARK:: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ApplicationColors.BACKGROUNDCOLOR
        print("Into MainViewController")
        setupViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupViews(){
        collectionView.removeConstraints(collectionViewConstraints)
        collectionView.removeFromSuperview()
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.setCollectionViewLayout(GridLayout(), animated: false)
        numberOfItemsCount.text = "\(numberOfItems)"
        
        self.view.addSubview(collectionView)
        self.view.addSubview(minusBtn)
        self.view.addSubview(numberOfItemsCount)
        self.view.addSubview(plusBtn)
        
        let itemHeight = GridLayout().itemHeight()
        if numberOfItems <= 5
        {
            collectionViewConstraints = collectionView.anchorWithReturnAnchors(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: viewSeparatorSpace, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: itemHeight)
        }
        else{
            collectionViewConstraints = collectionView.anchorWithReturnAnchors(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: viewSeparatorSpace, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: itemHeight*2)
        }
        
        minusBtn.anchor(collectionView.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        numberOfItemsCount.anchor(collectionView.bottomAnchor, left: minusBtn.rightAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        plusBtn.anchor(collectionView.bottomAnchor, left: numberOfItemsCount.rightAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection View cell click at :: \(indexPath.item)")
    }
}
