//
//  PopupChooseEmotionViewController.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 8/5/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class PopupChooseeEmojiViewController : TNBaseViewController {
    
    var viewContainer = UIView()
    var listIcon : [UIImageView] = []
    var stackIcon = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)
    
    override func viewDidLoad() {
        setupUI()
    }
    
    
}

extension PopupChooseeEmojiViewController {
    func setupUI(){
        self.view.backgroundColor = .clear
        self.view.addSubview(viewContainer)
        viewContainer.backgroundColor = .white
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 8)
            maker.width.equalTo((Constant.size.avatarNormal + 4) * 6 + 4)
            maker.center.equalToSuperview()
        }
        viewContainer.layer.cornerRadius = (Constant.size.avatarNormal + 8) / 2
        listIcon.append(UIImageView(image: UIImage(named: TNEmoji.like.rawValue)))
        listIcon.append(UIImageView(image: UIImage(named: TNEmoji.haha.rawValue)))
        listIcon.append(UIImageView(image: UIImage(named: TNEmoji.wow.rawValue)))
        listIcon.append(UIImageView(image: UIImage(named: TNEmoji.cry.rawValue)))
        listIcon.append(UIImageView(image: UIImage(named: TNEmoji.angry.rawValue)))
        listIcon.append(UIImageView(image: UIImage(named: TNEmoji.heart.rawValue)))
        viewContainer.addSubview(stackIcon)
        stackIcon.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview().offset(-8)
            maker.height.equalToSuperview().offset(-8)
        }
        stackIcon.arrangedSubviews.forEach({$0.removeFromSuperview()})
        for item in listIcon {
            item.snp.makeConstraints { (maker) in
                maker.width.equalTo(Constant.size.avatarNormal)
                maker.height.equalTo(item.snp.width)
            }
            self.stackIcon.addArrangedSubview(item)
//            item.addGestureRecognizer(UIGes)
        }
    }
}
