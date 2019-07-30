//
//  NewPostCell.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/13/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol TNNewPostDelegate {
    @objc func newPostAvatarTap(_ gesture : UIGestureRecognizer)
    @objc func newPostNewTap(_ gesture : UIGestureRecognizer)
    @objc func newPostPickImageTap(_ gesture : UIGestureRecognizer)
}

class TNNewPostCell : UITableViewCell {
    
    static let identify = "TNNewPostCell"
    let avatar = ReuseForms.btnAvatar()
    let buttonNew = UIButton(title: "Viết gì đó cho cả lớp", font: Constant.text.font.normal, titleColor: Constant.text.color.black, backColor: .clear, action: nil)
    let btnLibrary = UIButton()
    var delegate : TNNewPostDelegate? = nil {
        didSet {
            avatar.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.newPostAvatarTap(_:))))
            buttonNew.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.newPostNewTap(_:))))
            btnLibrary.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.newPostPickImageTap(_:))))
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
//        self.snp.makeConstraints { (maker) in
//            maker.height.equalTo(Constant.size.avatarNormal + Constant.size.paddingView)
//        }
        
        let stackNew = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
        self.addSubview(stackNew)
        stackNew.layoutMargins = UIEdgeInsets(top: 0, left: Constant.size.paddingView, bottom: 0, right: Constant.size.paddingView)
        stackNew.isLayoutMarginsRelativeArrangement = true
        stackNew.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
            maker.height.equalTo(Constant.size.avatarNormal + Constant.size.paddingView)
        }
        
        stackNew.addArrangedSubview(avatar)
        
        stackNew.addArrangedSubview(buttonNew)
        buttonNew.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
        }
        
        stackNew.addArrangedSubview(UIView())
        
        stackNew.addArrangedSubview(btnLibrary)
        btnLibrary.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.btnIcon)
            maker.width.equalTo(btnLibrary.snp.height)
        }
        btnLibrary.setImage(UIImage(named: "ic_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnLibrary.imageView?.contentMode = .scaleAspectFit
        btnLibrary.tintColor = Constant.color.iconColor
    }
}
