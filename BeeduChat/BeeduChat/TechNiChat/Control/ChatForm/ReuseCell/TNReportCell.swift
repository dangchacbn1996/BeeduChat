//
//  ReportCell.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

struct TNReportCellModel {
    var title : String = ""
    var subTitle : String = ""
    var iconStt : UIImage? = nil
    var percent : String = ""
    var btnAction : UIImage? = nil
}

class TNReportCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "ReportCell"
    var lblTitle = UILabel(text: "", textColor: Constant.text.color.black, font: Constant.text.font.normal)
    var lblSubTitle = UILabel(text: "", textColor: Constant.text.color.gray, font: Constant.text.font.normal)
    var btnStt = ReuseForms.imageAvatarSmall(nil)
    var lblPercent = UILabel(text: "", textColor: Constant.text.color.black, font: Constant.text.font.normal)
    var btnAct = UIButton()
    var stackViewTitle = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .leading, spacing: 0, design: nil)
    var stackViewStatus = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .leading, spacing: 0, design: nil)
    
    var data : TNReportCellModel = TNReportCellModel(){
        didSet{
            if(self.data.iconStt != nil){
                btnStt.image = self.data.iconStt
            }
            self.btnAct.setImage(UIImage(named: "ic_right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnAct.tintColor = Constant.color.iconColor
            self.btnAct.contentMode = .scaleAspectFit
            lblTitle.text = self.data.title
            lblSubTitle.text = self.data.subTitle
            lblPercent.text = self.data.percent
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TNReportCell.identifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }

}
extension TNReportCell{
    func setupUI(){
        self.addSubview(stackViewTitle)
        stackViewTitle.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        stackViewTitle.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        (stackViewTitle as! UIStackView).addArrangedSubview(self.lblTitle,design: nil)
        (stackViewTitle as! UIStackView).addArrangedSubview(lblSubTitle, design: nil)
        
        self.addSubview(stackViewStatus)
        stackViewStatus.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        stackViewStatus.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        (stackViewStatus as! UIStackView).addArrangedSubview(self.btnStt,design: nil)
        (stackViewStatus as! UIStackView).addArrangedSubview(self.lblPercent,design: nil)
        (stackViewStatus as! UIStackView).addArrangedSubview(btnAct)
        
    }
}
