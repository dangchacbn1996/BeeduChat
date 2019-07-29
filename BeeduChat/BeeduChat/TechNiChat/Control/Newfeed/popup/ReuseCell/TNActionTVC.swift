//
//  TNOptionTVC.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class TNActionTVC: UITableViewCell {

    static let identify = "TNActionTVC"
    static var estimateSize = Constant.size.avatarNormal + 12
    var ivIcon = UIImageView(frame: .zero)
    var lbOption = UILabel(text: "",
                           font: Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Bold),
                           textColor: Constant.text.color.black)
    var lbDescript = UILabel(text: "",
                             font: Constant.text.font.normal,
                             textColor: Constant.text.color.black)
    var messable = false
    var data : TNActionModel = TNActionModel(icon: UIImage(), option: "", description: "") {
        didSet {
            ivIcon.image = self.data.icon.withRenderingMode(.alwaysTemplate)
            lbOption.text = self.data.option
            lbDescript.text = self.data.description
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
        self.addSubview(ivIcon)
        ivIcon.tintColor = Constant.text.color.black
        ivIcon.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(Constant.size.paddingView)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(ivIcon.snp.height)
            maker.height.equalToSuperview().offset(-18)
        }
        self.addSubview(UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 2, design: nil)) { (stack) -> (Void) in
            stack.snp.makeConstraints({ (maker) in
                maker.leading.equalTo(self.ivIcon.snp.trailing).offset(8)
                maker.centerY.equalToSuperview()
                maker.trailing.equalToSuperview().offset(-Constant.size.paddingView)
            })
            (stack as! UIStackView).addArrangedSubview(self.lbOption)
            (stack as! UIStackView).addArrangedSubview(self.lbDescript)
        }
    }
}
