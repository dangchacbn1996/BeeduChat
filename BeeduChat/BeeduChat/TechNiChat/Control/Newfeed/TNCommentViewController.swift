//
//  NewsSubViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNCommentViewController : UIViewController {
    
    var stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 0, design: nil)
//    var stackNew = UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 8, design: nil)
    var stackComment = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 8, design: nil)
    var index = 0
    var content : TNCommentSubViewController!
    
    static func createInstance(index : Int) -> (TNCommentViewController){
        let vc = TNCommentViewController()
        vc.index = index
        return vc
    }
    
    func reloadData(){
        content.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension TNCommentViewController {
    func setupUI() {
        self.view.addSubview(stackComment)
        stackComment.snp.makeConstraints { (maker) in
            maker.centerX.width.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
//        stackMain.addArrangedSubview(UIView()) { (separate) -> (Void) in
//            separate.backgroundColor = Constant.color.separate
//            separate.snp.makeConstraints({ (maker) in
//                maker.height.equalTo(Constant.size.separatorHeight)
//            })
//        }
//        stackMain.addArrangedSubview(stackComment)
        setupComment()
    }
    
    func setupComment(){
        stackComment.layoutMargins = UIEdgeInsets(top: 12, left: Constant.size.paddingView, bottom: 8, right: Constant.size.paddingView)
        stackComment.isLayoutMarginsRelativeArrangement = true
        stackComment.addArrangedSubview(UILabel(text: " Xem thêm bình luận khác", textColor: Constant.text.color.gray, font: nil), design: nil)
//        stackComment.snp.makeConstraints { (maker) in
//            maker.height.equalTo(550)
//        }
        
        content = TNCommentSubViewController.createInstance(index: index)
        self.addChild(content)
        content.didMove(toParent: self)
        stackComment.addArrangedSubview(content.view)
//        content.view.snp.makeConstraints { (maker) in
//            maker.height.equalTo(content.tableComment.contentSize.height)
//        }
    }
}
