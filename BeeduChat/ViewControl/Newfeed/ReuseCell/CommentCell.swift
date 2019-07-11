//
//  CommentCell.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

struct CommentGeneralModel {
    var avatar : UIImage? = nil
    var name : String = ""
    var time : String = ""
    var content : String = ""
    var isAnswer : Bool = true
}

class CommentCell : UITableViewCell {
    static let identify = "CommentCell"
    var imAvatar = ReuseForms.imageAvatar(nil)
    var lbTime = UILabel(text: "", textColor: Constant.text.color.gray, font: Constant.text.font.small)
    var lbUser = UILabel(text: "",
                         textColor: Constant.text.color.black,
                         font: Constant.text.font.customFont(
                            size: Constant.text.size.normal,
                            weight: Constant.text.font.weight.Bold))
    var lbContent = UILabel(text: "",
                            textColor: Constant.text.color.black,
                            font: Constant.text.font.normal)
    var btnLike = UIButton(title: "Thích",
                           font: Constant.text.font.customFont(size: Constant.text.size.small, weight: .Bold),
                           titleColor: Constant.color.btnTitle,
                           backColor: .clear, action: nil)
    var btnComment = UIButton(title: "Bình luận",
                              font: Constant.text.font.customFont(size: Constant.text.size.small, weight: .Bold),
                              titleColor: Constant.color.btnTitle,
                              backColor: .clear, action: nil)
    var stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading, spacing: 4, design: nil)
    var data : CommentGeneralModel = CommentGeneralModel() {
        didSet {
            if (self.data.avatar != nil) {
                imAvatar.image = self.data.avatar!
            }
            lbTime.text = self.data.time
            lbUser.text = self.data.name
            lbContent.text = self.data.content
            if (self.data.isAnswer) {
                imAvatar.snp.makeConstraints { (maker) in
                    maker.leading.equalToSuperview().offset(Constant.size.iconNormal + 16)
                }
            } else {
                imAvatar.snp.makeConstraints { (maker) in
                    maker.leading.equalToSuperview().offset(8)
                }
            }
            if (self.data.content.count > self.data.name.count) {
                self.lbUser.snp.makeConstraints { (maker) in
                    maker.trailing.equalToSuperview().offset(-8)
                }
                self.lbContent.snp.makeConstraints { (maker) in
                    maker.trailing.lessThanOrEqualToSuperview().offset(-8)
                }
            } else {
                self.lbContent.snp.makeConstraints { (maker) in
                    maker.trailing.equalToSuperview().offset(-8)
                }
                self.lbUser.snp.makeConstraints { (maker) in
                    maker.trailing.lessThanOrEqualToSuperview().offset(-8)
                }
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

extension CommentCell {
    func setupUI(){
        self.addSubview(imAvatar)
        self.backgroundColor = UIColor.white
        imAvatar.snp.makeConstraints({ (maker) in
            maker.top.equalToSuperview().offset(8)
        })
        
        self.addSubview(stackMain)
        stackMain.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.imAvatar.snp.trailing).offset(8)
            maker.top.equalTo(self.imAvatar.snp.top)
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        let viewContent = UIView(background: Constant.color.commentBack, height: nil, ratioHW: nil, corner: 12, border: 0, borderColor: nil, design: nil)
        viewContent.addSubview(lbUser)
        lbUser.numberOfLines = 0
        lbUser.snp.makeConstraints { (maker) in
            maker.top.leading.equalToSuperview().offset(8)
        }
        lbContent.numberOfLines = 0
        viewContent.addSubview(lbContent)
        lbContent.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.lbUser.snp.bottom).offset(8)
            maker.bottom.equalToSuperview().offset(-8)
            maker.leading.equalTo(self.lbUser.snp.leading)
        }
        stackMain.addArrangedSubview(viewContent)
        stackMain.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: 4, design: nil)) { (stackAction) -> (Void) in
            (stackAction as! UIStackView).addArrangedSubview(self.lbTime)
            (stackAction as! UIStackView).addArrangedSubview(UIView(background: .clear, height: 4, ratioHW: 1, corner: 1, border: 0, borderColor: nil, design: nil))
            (stackAction as! UIStackView).addArrangedSubview(self.btnLike)
            (stackAction as! UIStackView).addArrangedSubview(UIView(background: Constant.color.separate, height: 2, ratioHW: 1, corner: 1, border: 0, borderColor: nil, design: nil))
            (stackAction as! UIStackView).addArrangedSubview(self.btnComment)
        }
    }
}

