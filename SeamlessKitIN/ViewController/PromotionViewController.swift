//
//  PromotionViewController.swift
//  SeamlessKitIN
//
//  Created by Ram Mhapasekar on 5/22/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

//MARK:
//MARK:: Delegate
protocol PromotionViewDelegate:class{
    func dismissView(sender: PromotionViewController)
}


//MARK:
//MARK:: Class
class PromotionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    let cellSpacingHeight: CGFloat = 5

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
        let attributeString = NSMutableAttributedString(string: "PROMOTION",
                                                        attributes: titleAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(dismissBtnClick), for: .touchUpInside)
        return button
    }()
    
    lazy var promotionsTableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.white
        tableView.register(PromotionsTableViewCell.self, forCellReuseIdentifier: "promotionsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        return tableView
    }()    
    
    
    //MARK:
    //MARK:: ViewController Methods
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
    
    fileprivate func setupVC()
    {
        self.view.addSubview(dismissBtn)
        self.view.addSubview(promotionsTableView)
        
        dismissBtn.anchor(self.view.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.view.frame.width, heightConstant: 40)
        dismissBtn.anchorCenterXToSuperview(constant: 0)
        promotionsTableView.anchor(dismissBtn.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, topConstant: viewSeparatorSpace, leftConstant: gutterSpace, bottomConstant: viewSeparatorSpace, rightConstant: gutterSpace, widthConstant: 0, heightConstant: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:
    //MARK:: TableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "promotionsTableViewCell", for: indexPath) as? PromotionsTableViewCell else{
            fatalError("Unexpected TableView Cell")
        }
        cell.promotionTitleLabel.text = "Promotion \(indexPath.section + 1)"
        cell.promotionDescriptionLabel.text = "Get Rs. 50 off on purchase above Rs. 2000 on use of VISA credit cards."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    //MARK:
    //MARK:: Button click handling
    /**
     Method: dismissBtnClick
     This method envokes the delegate method.
     */
    @objc fileprivate func dismissBtnClick(){
        self.promotionDelegate?.dismissView(sender: self)
    }
}
