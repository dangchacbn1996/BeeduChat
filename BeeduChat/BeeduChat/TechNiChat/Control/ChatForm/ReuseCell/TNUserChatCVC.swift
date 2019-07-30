//
//  UserChatCVC.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/17/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class TNUserChatCVC: UICollectionViewCell {
    
    static let identify = "TNUserChatCVC"
    static let cellSize = CGSize(width: Constant.size.avatarNormal + 16, height: Constant.size.avatarNormal + 24)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TNUserChatCVC {
    func setupUI(){
        self.backgroundColor = UIColor.white
        self.addSubview(UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 4, design: nil)) { (stackMain) -> (Void) in
            stackMain.snp.makeConstraints({ (maker) in
                maker.center.height.equalToSuperview()
                maker.height.equalTo(TNUserChatCVC.cellSize.height)
                maker.width.equalToSuperview().offset(-16)
                maker.width.equalTo(TNUserChatCVC.cellSize.width).offset(-16)
            })
            (stackMain as! UIStackView).addArrangedSubview(ReuseForms.btnAvatar(), design: { (avatar) -> (Void) in
                avatar.snp.makeConstraints({ (maker) in
                    maker.height.width.equalTo(Constant.size.avatarNormal)
                })
            })
            (stackMain as! UIStackView).addArrangedSubview(UILabel(text: "User", textColor: Constant.text.color.black, font: Constant.text.font.normal))
        }
    }
}
