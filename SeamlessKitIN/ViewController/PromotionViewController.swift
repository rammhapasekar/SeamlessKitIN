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
        let attributeString = NSMutableAttributedString(string: "Dismiss Promotion VC",
                                                        attributes: titleAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(dismissBtnClick), for: .touchUpInside)
        return button
    }()
    
    lazy var promotionsTableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.white
        
        //MARK:
        //MARK:: register cell for table view here
        
        tableView.register(PromotionsTableViewCell.self, forCellReuseIdentifier: "promotionsTableViewCell")
        
        //MARK:
        //MARK:: data sources and delegate for table view
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        return tableView
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
    
    fileprivate func setupVC()
    {
//        self.view.addSubview(dismissBtn)
        
//        dismissBtn.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 100, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 250, heightConstant: 40)
//        dismissBtn.anchorCenterXToSuperview(constant: 0)
        
        self.view.addSubview(promotionsTableView)
        
        let views: [String: Any] = ["promotionsTableView" : promotionsTableView]
        
        let matrics = ["gutterValue" : 10]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[promotionsTableView]-|", options: [], metrics: matrics, views: views))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[promotionsTableView]|", options: [], metrics: nil, views: views))
    }
    
    //MARK:
    //MARK:: data sources and delegate methods
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "promotionsTableViewCell", for: indexPath) as! PromotionsTableViewCell
        
        // add border and color
        cell.backgroundColor = UIColor.clear
        cell.layer.borderColor = ApplicationColors.TEXTCOLOR.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.promotionTitleLabel.text = "Promotion \(indexPath.section + 1)"
        print("----\(indexPath.row)")
        cell.promotionDescriptionLabel.text = "Get Rs. 50 off on purchase above Rs. 2000 on use of VISA credit cards."
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    
    @objc fileprivate func dismissBtnClick(){
        self.promotionDelegate?.dismissView(sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
