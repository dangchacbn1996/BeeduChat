//
//  NewPostCell.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/13/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNPostInfoCell : UITableViewCell {
    
    static let identify = "TNPostInfoCell"
    var actLike : UITapGestureRecognizer!
    var actComment : UITapGestureRecognizer!
    var actAvatar : UITapGestureRecognizer!
    var actPin : UITapGestureRecognizer!
    var actMore : UITapGestureRecognizer!
    var actEmoji : UITapGestureRecognizer!
    
    var data : TNPostInfoModel = TNPostInfoModel() {
        didSet {
            self.subviews.forEach { (sub) in
                sub.removeFromSuperview()
            }
            self.addSubview(UIView()) { (contentBack) -> (Void) in
                contentBack.backgroundColor = Constant.color.postBack
                contentBack.snp.makeConstraints({ (maker) in
                    maker.top.centerX.width.height.equalToSuperview()
                    maker.height.equalToSuperview().offset(-8)
                })
                contentBack.addSubview(TNPostView.postView(self.data, actAvatar: self.actAvatar, actLike: self.actLike, actEmoji: self.actEmoji), design: { (post) -> (Void) in
                    post.snp.makeConstraints({ (maker) in
                        maker.top.leading.trailing.equalToSuperview()
                        maker.bottom.equalToSuperview().offset(-8)
                    })
                })
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI(){
        self.backgroundColor = Constant.color.separateNewFeed
//        self.addSubview(UIView()) { (contentBack) -> (Void) in
//            contentBack.backgroundColor = Constant.color.postBack
//            contentBack.snp.makeConstraints({ (maker) in
//                maker.top.centerX.width.height.equalToSuperview()
//                maker.height.equalToSuperview().offset(-8)
//            })
//            contentBack.addSubview(TNPostView.postInfo(), design: { (post) -> (Void) in
//                post.snp.makeConstraints({ (maker) in
//                    maker.top.leading.trailing.equalToSuperview()
//                    maker.bottom.equalToSuperview().offset(-8)
//                })
//            })
//        }
    }
}
