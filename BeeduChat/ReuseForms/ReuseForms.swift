//
//  ReuseForms.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/10/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class ReuseForms {
    static func imageAvatar() -> (UIImageView){
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFit
        avatar.image = UIImage(named: "ic_ava")
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = Constant.size.avatarNormal / 2
        avatar.snp.makeConstraints { (maker) in
            maker.width.equalTo(avatar.snp.height)
            maker.height.equalTo(Constant.size.avatarNormal)
        }
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = Constant.color.separate.cgColor
        return avatar
    }
    
    static func imageAvatar(_ image : UIImage?) -> (UIImageView){
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFit
        avatar.image = image ?? UIImage(named: "ic_ava")
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = Constant.size.avatarNormal / 2
        avatar.snp.makeConstraints { (maker) in
            maker.width.equalTo(avatar.snp.height)
            maker.height.equalTo(Constant.size.avatarNormal)
        }
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = Constant.color.separate.cgColor
        return avatar
    }
    
    static func imageAvatarSmall(_ image : UIImage?) -> (UIImageView){
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFit
        avatar.image = image ?? UIImage(named: "ic_ava")
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = Constant.size.avatarSmall / 2
        avatar.snp.makeConstraints { (maker) in
            maker.width.equalTo(avatar.snp.height)
            maker.height.equalTo(Constant.size.avatarSmall)
        }
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = Constant.color.separate.cgColor
        return avatar
    }
    
    static func btnAvatar() -> (UIButton){
        let avatar = UIButton()
        avatar.contentMode = .scaleAspectFit
        avatar.setImage(UIImage(named: "ic_ava"), for: .normal)
        avatar.snp.makeConstraints { (maker) in
            maker.width.equalTo(avatar.snp.height)
            maker.height.equalTo(Constant.size.avatarNormal)
        }
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = Constant.size.avatarNormal / 2
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = Constant.color.separate.cgColor
        return avatar
    }
    
    static func ima() -> (UIImageView){
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFit
        avatar.image = UIImage(named: "ic_ava")
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = Constant.size.avatarNormal / 2
        avatar.snp.makeConstraints { (maker) in
            maker.width.equalTo(avatar.snp.height)
            maker.height.equalTo(Constant.size.avatarNormal)
        }
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = Constant.color.separate.cgColor
        return avatar
    }
}
