//
//  DetailMessageCell.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/13/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

struct DetailMessageCellModel {
    var avatar : UIImage? = nil
    var nameID : String = ""
}

class DetailMessageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identify = "DetailMessageCell"
    var imgAvatar = ReuseForms.imageBig(nil)
    var lblUser = UILabel(text: "", textColor: Constant.text.color.black, font: Constant.text.font.normal)
    var data : DetailMessageCellModel = DetailMessageCellModel() {
        didSet{
            if(self.data.avatar != nil){
                imgAvatar.image = self.data.avatar!
            }
            lblUser.text = self.data.nameID
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

extension DetailMessageCell{
    func setupUI(){
        self.addSubview(imgAvatar)
        imgAvatar.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        self.addSubview(lblUser)
        lblUser.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.height.equalTo(self.imgAvatar.snp.height)
            maker.leading.equalTo(self.imgAvatar.snp.trailing).offset(8)
        }
    }
}
