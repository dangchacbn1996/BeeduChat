//
//  NewPostCell.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/13/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class PostInfoCell : UITableViewCell {
    
    static let identify = "PostInfoCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI(){
        self.backgroundColor = Constant.color.separate
        self.addSubview(UIView()) { (contentBack) -> (Void) in
            contentBack.backgroundColor = Constant.color.postBack
            contentBack.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.height.equalToSuperview()
                maker.height.equalToSuperview().offset(-8)
            })
            contentBack.addSubview(PostView.postInfo(), design: { (post) -> (Void) in
                post.snp.makeConstraints({ (maker) in
                    maker.top.leading.trailing.equalToSuperview()
                    maker.bottom.equalToSuperview().offset(-8)
                })
            })
        }
    }
}
