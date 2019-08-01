//
//  TNCreateNotificationTableViewCell.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/31/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

struct CreateNotifyModel {
    var datetime : String = ""
    var title : String = ""
    var content : String = ""
}

class TNCreateNotificationTableViewCell: UITableViewCell {
    static let identify = "TNCreateNotificationCell"
    var viewContent = UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 0, design: nil)
    var ceparateView = UIView()
    var stackView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 8, design: nil)
    var DateTimeView = UIView()
    var lblDatetime = UILabel(text: "", textColor: Constant.text.color.black, font: Constant.text.font.normal)
    var lblTitle = UILabel(text: "", textColor: Constant.text.color.black, font: Constant.text.font.customFont(size: Constant.text.size.large, weight: Constant.text.font.weight.Bold))
    var lblContent = UILabel(text: "", textColor: Constant.text.color.black, font: Constant.text.font.normal)
    var btnRight = UIButton()
    
    var data : CreateNotifyModel = CreateNotifyModel(){
        didSet{
            lblContent.text = self.data.content
            lblTitle.text = self.data.title
            lblDatetime.text = self.data.datetime
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension TNCreateNotificationTableViewCell{
    func setupUI(){
        self.addSubview(DateTimeView)
        DateTimeView.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
            maker.center.equalToSuperview()
        }
        DateTimeView.addSubview(lblDatetime)
        lblDatetime.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        } 
        self.addSubview(viewContent)
        viewContent.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblDatetime.snp.bottom).offset(8)
            maker.left.equalToSuperview().offset(80)
            maker.right.equalToSuperview().offset(-4)
//            maker.bottom.equalToSuperview()
        }
        viewContent.addArrangedSubview(ceparateView)
        ceparateView.snp.makeConstraints { (maker) in
            maker.width.equalTo(4)
            maker.height.equalToSuperview()
            maker.left.equalToSuperview()
        }
        ceparateView.backgroundColor = Constant.color.btnContinue
        viewContent.addArrangedSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
//            maker.top.right.bottom.left.equalToSuperview().offset(4)
            maker.left.equalTo(ceparateView.snp.right).offset(4)
            maker.right.equalToSuperview().offset(4)
        }
        stackView.addArrangedSubview(lblTitle)
        lblTitle.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(8)
            maker.right.equalToSuperview().offset(8)
            maker.left.equalToSuperview().offset(8)
        }
        stackView.addArrangedSubview(lblContent)
        lblContent.snp.makeConstraints { (maker) in
            maker.left.bottom.right.equalToSuperview().offset(8)
        }
        lblContent.numberOfLines = 0
    }
}
