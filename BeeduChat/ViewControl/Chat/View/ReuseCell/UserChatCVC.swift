//
//  UserChatCVC.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/17/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class UserChatCVC: UICollectionViewCell {
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UserChatCVC {
    func setupUI(){
        self.addSubview(UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 4, design: nil)) { (stackMain) -> (Void) in
            stackMain.snp.makeConstraints({ (maker) in
                maker.center.height.equalToSuperview()
                maker.width.equalToSuperview().offset(-16)
            })
            (stackMain as! UIStackView).addArrangedSubview(ReuseForms.imageBig())
            (stackMain as! UIStackView).addArrangedSubview(UILabel(text: "User", textColor: Constant.text.color.black, font: Constant.text.font.normal))
        }
    }
}
