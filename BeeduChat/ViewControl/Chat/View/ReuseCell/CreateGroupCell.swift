//
//  CreateGroupCell.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/20/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

struct CreateGroupCellModel {
    var avatar : UIImage? = nil
    var name : String = ""
    var content : String = ""
}

class CreateGroupCell: UITableViewCell {
    static let identify = "CreateGroupCell"
    var imAvatar = ReuseForms.imageBig()
    var lbUser = UILabel(text: "",
                         textColor: Constant.text.color.black,
                         font: Constant.text.font.customFont(
                            size: Constant.text.size.normal,
                            weight: Constant.text.font.weight.Bold))
    var lbContent = UILabel(text: "",
                            textColor: Constant.text.color.black,
                            font: Constant.text.font.normal)
    var data : CreateGroupCellModel = CreateGroupCellModel(){
        didSet{
            if (self.data.avatar != nil)
            {
                imAvatar.image = self.data.avatar
            }
            lbUser.text = self.data.name
            lbContent.text = self.data.content
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
extension CreateGroupCell{
    func setupUI(){
        self.addSubview(imAvatar)
        imAvatar.snp.makeConstraints({ (maker) in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalToSuperview().offset(-16)
        })
        
        self.addSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .leading, spacing: -12, design: nil)) { (stackView) -> (Void) in
            stackView.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.height.equalTo(self.imAvatar.snp.height)
                maker.leading.equalTo(self.imAvatar.snp.trailing).offset(8)
            })
            stackView.setContentHuggingPriority(UILayoutPriority(rawValue: 40), for: .horizontal)
            (stackView as! UIStackView).addArrangedSubview(self.lbUser, design: nil)
            print(self.lbUser.font.fontDescriptor)
            (stackView as! UIStackView).addArrangedSubview(self.lbContent, design: nil)
        }
    }
}
