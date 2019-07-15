//
//  DetailMessCellTableViewCell.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/15/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

struct DetailMessModel {
    var avartar : UIImage? = nil
    var user : String = ""
}

class DetailMessCellTableViewCell: UITableViewCell {

    static let identify = "DetailMessCellTableViewCell"
    var imAvatar = ReuseForms.imageBig()
    var lbUser = UILabel(text: "",
                         textColor: Constant.text.color.black,
                         font: Constant.text.font.customFont(
                            size: Constant.text.size.normal,
                            weight: Constant.text.font.weight.Bold))
    
    var data : DetailMessModel = DetailMessModel(){
        didSet{
            if (self.data.avartar != nil) {
                imAvatar.image = self.data.avartar!
            }
            lbUser.text = self.data.user
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension DetailMessCellTableViewCell {
    func setupUI(){
        self.addSubview(imAvatar)
        imAvatar.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview()
            maker.bottom.equalTo(self.imAvatar.snp.bottom)
            maker.height.equalToSuperview().offset(-16)
        }
        self.addSubview(lbUser)
        lbUser.snp.makeConstraints { (maker) in
            maker.left.equalTo(imAvatar.snp.right).offset(8)
            maker.centerX.equalTo(imAvatar.snp.centerX)
        }
    }
}
