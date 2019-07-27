//
//  CustomCollectionViewLayout.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/18/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class TNCustomCollectionLayout : UICollectionViewFlowLayout {
    override init() {
        super.init()
        itemSize = TNUserChatCVC.cellSize
        estimatedItemSize = TNUserChatCVC.cellSize
        minimumInteritemSpacing = 0
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
