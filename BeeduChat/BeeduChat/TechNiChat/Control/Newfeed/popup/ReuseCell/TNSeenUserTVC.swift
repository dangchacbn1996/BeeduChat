//
//  TNSeenUserTVC.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/25/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class TNSeenUserTVC : UITableViewCell {
    
    static let identify = "TNSeenUserTVC"
    var ivUser = UIImageView(frame: .zero)
    var lbUser = UILabel(text: "", font: Constant.text.font.normal, textColor: Constant.text.color.black)
    var btnMess = UIButton(frame: .zero)
    var messable = false
    var data : TNEmotionModel = TNEmotionModel(){
        didSet{
            btnMess.isHidden = messable ? false : true
            ivUser.image = UIImage(named: data.userAvatar)
            lbUser.text = data.userName
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        let stackCell = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
        addSubview(stackCell)
        stackCell.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview().offset(-16)
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(24)
            maker.trailing.equalToSuperview().offset(-16)
        }
        stackCell.addArrangedSubview(ivUser)
        stackCell.addArrangedSubview(lbUser)
        stackCell.addArrangedSubview(btnMess)
        
        ivUser.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal)
            maker.height.equalToSuperview()
            maker.width.equalTo(ivUser.snp.height)
        }
        btnMess.snp.makeConstraints { (maker) in
            maker.width.equalTo(btnMess.snp.height)
            maker.height.equalTo(Constant.size.avatarNormal * 0.7)
        }
        btnMess.imageView?.contentMode = .scaleAspectFit
    }
}
