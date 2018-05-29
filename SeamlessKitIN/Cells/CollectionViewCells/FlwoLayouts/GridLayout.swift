//
//  GridLayout.swift
//  SeamlessKitIN
//
//  Created by Mayur Shinde on 25/05/18.
//  Copyright © 2018 Ram Mhapasekar. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout
{    
    let innerSpace: CGFloat = 20
    let numberOfCellsOnRow: CGFloat = 3
    
    override init() {
        super.init()
        self.minimumLineSpacing = innerSpace
        self.minimumInteritemSpacing = innerSpace
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //self.scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func itemWidth() -> CGFloat
    {
        if numberOfItems > 4 {
            return ((viewWidth)/self.numberOfCellsOnRow)-self.innerSpace
        }
        return (viewWidth/CGFloat(numberOfItems))
    }
    
    func itemHeight() -> CGFloat
    {
        
        return 60//((viewWidth-30)/self.numberOfCellsOnRow)-self.innerSpace
    }
    
    override var itemSize: CGSize {
        set {
            if numberOfItems == 6 {
                self.itemSize = CGSize(width:itemWidth(), height:itemHeight())
            }
            self.itemSize = CGSize(width:itemWidth(), height:itemHeight())
        }
        get {
            if numberOfItems == 6 {
                return CGSize(width:itemWidth(), height:itemHeight())
            }
            return CGSize(width:itemWidth(),height:itemHeight())
        }
    }
}
