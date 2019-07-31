//
//  ChatGeneralCell.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

struct ChatGeneralModel {
    var avatar : UIImage? = nil
    var name : String = ""
    var time : String = ""
    var content : String = ""
    var isRead : Bool = true
}

class TNChatGeneralCell : UITableViewCell {
    
    static let identify = "ChatGeneralCell"
    var imAvatar = ReuseForms.imageBig()
    var lbTime = UILabel(text: "", textColor: Constant.text.color.gray, font: Constant.text.font.small)
    var lbUser = UILabel(text: "",
                         textColor: Constant.text.color.black,
                         font: Constant.text.font.customFont(
                            size: Constant.text.size.large,
                            weight: Constant.text.font.weight.Bold))
    var lbContent = UILabel(text: "",
                            textColor: Constant.text.color.black,
                            font: Constant.text.font.normal)
    var data : ChatGeneralModel = ChatGeneralModel() {
        didSet {
            if (self.data.avatar != nil) {
                imAvatar.image = self.data.avatar!
            }
            lbTime.text = self.data.time
            lbUser.text = self.data.name
            lbContent.text = self.data.content
            if (self.data.isRead) {
                lbContent.font = Constant.text.font.normal
            } else {
                lbContent.font = Constant.text.font.customFont(size: Constant.text.size.normal, weight: Constant.text.font.weight.Bold)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TNChatGeneralCell {
    func setupUI(){
        self.addSubview(imAvatar)
        imAvatar.snp.makeConstraints({ (maker) in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalToSuperview().offset(-16)
        })
        self.addSubview(UIView()) { (noti) -> (Void) in
            noti.snp.makeConstraints({ (maker) in
                maker.width.equalTo(noti.snp.height)
                maker.width.equalTo(16)
                maker.bottom.equalTo(self.imAvatar.snp.top).offset(Constant.size.avatarBig * 3 / 4 + 12)
                maker.trailing.equalTo(self.imAvatar.snp.leading).offset(Constant.size.avatarBig * 3 / 4 + 12)
            })
            noti.backgroundColor = Constant.color.btnStartGradient
            noti.layer.cornerRadius = 8
            noti.clipsToBounds = true
            noti.layer.borderWidth = 2
            noti.layer.borderColor = UIColor.white.cgColor
        }
        
        self.addSubview(lbTime)
        lbTime.snp.makeConstraints({ (maker) in
            maker.trailing.equalToSuperview()
        })
        lbTime.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        
        self.addSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .leading, spacing: -12, design: nil)) { (stackView) -> (Void) in
            stackView.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.height.equalTo(self.imAvatar.snp.height)
                maker.leading.equalTo(self.imAvatar.snp.trailing).offset(8)
                maker.trailing.equalTo(self.lbTime.snp.leading).offset(-8)
            })
            stackView.setContentHuggingPriority(UILayoutPriority(rawValue: 40), for: .horizontal)
            (stackView as! UIStackView).addArrangedSubview(self.lbUser, design: nil)
            print(self.lbUser.font.fontDescriptor)
            (stackView as! UIStackView).addArrangedSubview(self.lbContent, design: nil)
        }
        lbTime.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(self.lbContent.snp.centerY)
        }
    }
}
