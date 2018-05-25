//
//  SavedCardsCell.swift
//  SeamlessKitIN
//
//  Created by Ram Mhapasekar on 5/25/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

class SavedCardsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    }
}
