//
//  TNSeenUserTVC.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/25/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

enum TNNotifiOption {
    case complete
    case processing
    case cancel
}

struct TNNotifiMode {
    var header : String = ""
    var content : String = ""
    var status : TNNotifiOption = .complete
    var percent : Int = 0
}

class TNNotifiTVCell : UITableViewCell {
    
    static let identify = "TNNotifiTVCell"
//    var ivUser = UIImageView(frame: .zero)
//    var lbUser = UILabel(text: "", font: Constant.text.font.normal, textColor: Constant.text.color.black)
//    var btnMess = UIButton(frame: .zero)
    var lbHeader = UILabel(text: "", textColor: Constant.text.color.black, font: Constant.text.font.customFont(size: Constant.text.size.large, weight: .Bold))
    var lbContent = UILabel(text: "", textColor: Constant.text.color.black, font: nil)
    var lbPercent = UILabel(text: "0%", textColor: Constant.text.color.black, font: nil)
    var ivStatus = UIImageView()
//    var messable = false
    var data : TNNotifiMode = TNNotifiMode(){
        didSet{
            lbHeader.text = data.header
            lbPercent.text = "\(data.percent)%"
            lbContent.text = data.content
            switch data.status {
            case .complete:
                ivStatus.image = UIImage(named: "Checkbox Green")
            default:
                ivStatus.image = UIImage(named: "Checkbox Orange")
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
    
    func setupUI(){
        self.addSubview(UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading, spacing: 4, design: nil)) { (stackInfo) -> (Void) in
            stackInfo.snp.makeConstraints({ (maker) in
                maker.leading.equalToSuperview().offset(Constant.size.paddingView)
                maker.centerY.equalToSuperview()
            })
            (stackInfo as! UIStackView).addArrangedSubview(self.lbHeader)
            (stackInfo as! UIStackView).addArrangedSubview(self.lbContent)
        }
        let btnMore = UIButton()
        self.addSubview(btnMore)
        btnMore.snp.makeConstraints({ (maker) in
            maker.trailing.equalToSuperview().offset(-Constant.size.paddingView)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(btnMore.snp.height)
            maker.height.equalTo(Constant.size.btnIcon)
        })
        btnMore.setImage(UIImage(named: "ic_right"), for: .normal)
        btnMore.imageView?.contentMode = .scaleAspectFit
        self.addSubview(lbPercent)
        lbPercent.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.trailing.equalTo(btnMore.snp.leading).offset(-8)
            maker.height.equalToSuperview()
        }
        self.addSubview(ivStatus)
        ivStatus.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(lbPercent.snp.leading).offset(-4)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(ivStatus.snp.height)
            maker.height.equalTo(Constant.size.btnIcon)
            maker.leading.equalTo(subviews[0].snp.trailing).offset(8)
        }
        
    }
}
