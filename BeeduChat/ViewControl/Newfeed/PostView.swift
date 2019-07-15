//
//  PostView.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/13/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import Foundation
import SnapKit

class PostView {
    
    static func navigationView(parent : UIView){
        let navigationView = UIView(background: Constant.color.naviBack, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: UIColor.gray, design: nil)
        var naviConstraint : NSLayoutConstraint!
        var btnMenu = UIButton()
        var btnNoti = UIButton()
        var btnMore = UIButton()
        var lbClass = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
        var lbSubClass = UILabel(text: "@fox.class", textColor: Constant.text.color.black, font: nil)
        parent.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(parent.safeAreaLayoutGuide)
            //            maker.height.equalTo(Constant.size.naviHeight)
        }
        naviConstraint = navigationView.heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
        naviConstraint.isActive = true
        
        /* Navigation
         **************************************
         * Menu         Class       noti more *
         **************************************
         */
        navigationView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)) { (stackNavi) -> (Void) in
            stackNavi.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.height.equalToSuperview().offset(-Constant.size.padingAround)
                maker.width.equalToSuperview().offset(-Constant.size.padingAround)
            })
            
            //Btn menu
            (stackNavi as! UIStackView).addArrangedSubview(btnMenu)
            btnMenu.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnMenu.snp.height)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            btnMenu.setImage(UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnMenu.tintColor = Constant.color.iconColor
            btnMenu.contentMode = .scaleAspectFit
            //            self.btnMenu.backgroundColor = UIColor.blue
            
            //Ten lop
            (stackNavi as! UIStackView).addArrangedSubview(UIView())
            
            navigationView.addSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil), design: { (stackClass) -> (Void) in
                stackClass.snp.makeConstraints({ (maker) in
                    maker.center.equalToSuperview()
                    //                    maker.height.equalToSuperview()
                    
                })
                (stackClass as! UIStackView).addArrangedSubview(lbClass)
                (stackClass as! UIStackView).addArrangedSubview(lbSubClass)
            })
            
            //Btn noti
            (stackNavi as! UIStackView).addArrangedSubview(btnNoti)
            btnNoti.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnNoti.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            btnNoti.setImage(UIImage(named: "ic_noti")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnNoti.tintColor = Constant.color.iconColor
            btnNoti.contentMode = .scaleAspectFit
            
            //Btn more
            (stackNavi as! UIStackView).addArrangedSubview(btnMore)
            btnMore.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnMore.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            btnMore.setImage(UIImage(named: "ic_more")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnMore.tintColor = Constant.color.iconColor
            btnMore.contentMode = .scaleAspectFit
        }
        
        /* Separate
         **************************************
         */
        parent.addSubview(UIView()) { (separate) -> (Void) in
            separate.snp.makeConstraints({ (maker) in
                maker.centerX.width.equalToSuperview()
                maker.top.equalTo(navigationView.snp.bottom).offset(1)
                maker.height.equalTo(1)
            })
            separate.backgroundColor = Constant.color.separate
        }
    }
    
    static func addPost() -> (UIView){
        let stackNew = UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 8, design: nil)
        let stackHead = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)
        stackNew.addArrangedSubview(stackHead)
        stackHead.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal)
        }
        
        stackHead.addArrangedSubview(ReuseForms.btnAvatar())
        
        stackHead.addArrangedSubview(UIView()) { (viewInfo) -> (Void) in
            viewInfo.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview()
            })
            //0
            viewInfo.addSubview(UILabel(text: "Co Huong", textColor: Constant.text.color.black, font: nil), design: { (lbUser) -> (Void) in
                lbUser.snp.makeConstraints({ (maker) in
                    maker.top.trailing.equalToSuperview()
                    maker.leading.equalToSuperview().offset(4)
                    maker.height.equalTo(Constant.size.avatarNormal / 2)
                })
            })
            //1
            viewInfo.addSubview(UILabel(text: "Lớp Fox", textColor: Constant.text.color.gray, font: Constant.text.font.small), design: { (lbClass) -> (Void) in
                lbClass.snp.makeConstraints({ (maker) in
                    maker.leading.equalTo(viewInfo.subviews[0].snp.leading)
                    maker.height.equalTo(Constant.size.avatarNormal / 2)
                    maker.top.equalTo(viewInfo.subviews[0].snp.bottom)
                })
            })
            //2
            viewInfo.addSubview(UIView(), design: { (separate) -> (Void) in
                separate.backgroundColor = Constant.color.separate
                separate.snp.makeConstraints({ (maker) in
                    maker.width.equalTo(1)
                    maker.leading.equalTo(viewInfo.subviews[1].snp.trailing).offset(4)
                    maker.centerY.equalTo(viewInfo.subviews[1].snp.centerY)
                    maker.height.equalTo((viewInfo.subviews[1] as! UILabel).font.lineHeight)
                })
            })
            //3
            viewInfo.addSubview(UILabel(text: "23 giờ trước ", textColor: Constant.text.color.gray, font: Constant.text.font.small), design: { (lbClass) -> (Void) in
                lbClass.snp.makeConstraints({ (maker) in
                    maker.leading.equalTo(viewInfo.subviews[2].snp.trailing).offset(4)
                    maker.centerY.height.equalTo(viewInfo.subviews[1])
                })
            })
        }
        
        stackHead.addArrangedSubview(UIButton()) { (btnNote) -> (Void) in
            btnNote.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnNote.snp.height).multipliedBy(0.7)
                maker.width.equalTo(Constant.size.iconNormal)
            })
            (btnNote as! UIButton).setImage(UIImage(named: "ic_star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            (btnNote as! UIButton).tintColor = Constant.color.btnTitle
            (btnNote as! UIButton).imageView?.contentMode = .scaleAspectFit
        }
        
        stackHead.addArrangedSubview(UIButton()) { (btnMore) -> (Void) in
            btnMore.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnMore.snp.height).multipliedBy(0.7)
                maker.width.equalTo(Constant.size.iconNormal)
            })
            (btnMore as! UIButton).setImage(UIImage(named: "ic_more_horizon")?.withRenderingMode(.alwaysTemplate), for: .normal)
            (btnMore as! UIButton).tintColor = Constant.color.iconColor
            (btnMore as! UIButton).imageView?.contentMode = .scaleAspectFit
        }
        
        stackNew.addArrangedSubview(stackHead)
        stackHead.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().offset(-16)
        }
        
        stackNew.addArrangedSubview(UILabel(text: "Năm 2015, ác quỷ Đầm Bích được đưa lên màn ảnh rộng qua bàn tay của bậc thầy kinh dị nước Nga ", textColor: Constant.text.color.black, font: nil)) { (lbPreview) -> (Void) in
            (lbPreview as! UILabel).numberOfLines = 0
            lbPreview.snp.makeConstraints({ (maker) in
                maker.width.equalToSuperview().offset(-16)
            })
        }
        
        stackNew.addArrangedSubview(UIImageView()) { (ivPreview) -> (Void) in
            ivPreview.snp.makeConstraints({ (maker) in
                maker.width.equalToSuperview()
                maker.height.equalTo(ivPreview.snp.width).multipliedBy(0.75)
            })
            (ivPreview as! UIImageView).image = UIImage(named: "photo")
            ivPreview.contentMode = .scaleAspectFit
        }
        
        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackLike) -> (Void) in
            stackLike.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.text.font.normal.lineHeight ?? 16)
                maker.width.equalToSuperview().offset(-16)
            })
            
            (stackLike as! UIStackView).addArrangedSubview(UIView(), design: { (viewLike) -> (Void) in
                viewLike.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            })
            (stackLike as! UIStackView).addArrangedSubview(
                UILabel(text: "18 bình luận", textColor: Constant.text.color.black, font: nil), design: { (viewLike) -> (Void) in
            })
            (stackLike as! UIStackView).addArrangedSubview(
                UILabel(text: "18 lượt xem", textColor: Constant.text.color.black, font: nil), design: { (viewLike) -> (Void) in
            })
        }
        
        stackNew.addArrangedSubview(UIView()) { (separate) -> (Void) in
            separate.snp.makeConstraints({ (maker) in
                maker.height.equalTo(1)
                maker.width.equalToSuperview().offset(-16)
            })
            separate.backgroundColor = Constant.color.separate
        }
        
        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 8, design: nil)) { (stackAction) -> (Void) in
            stackAction.snp.makeConstraints({ (maker) in
                maker.height.equalTo((Constant.text.font.normal.lineHeight ?? 16) * 1.5)
                maker.width.equalToSuperview().offset(-16)
            })
            
            

//            (stackAction as! UIStackView).addArrangedSubview(UIStackView(axis: .horizontal, distribution: ., alignment: .fill, spacing: 0, design: nil), design: { (stackLike) -> (Void) in
//                (stackLike as! UIStackView).addArrangedSubview(
//                    UIImageView(image: UIImage(named: "ic_like"), highlightedImage: nil), design: { (imvLike) -> (Void) in
//                        imvLike.tintColor = Constant.text.color.black
//                        imvLike.contentMode = .scaleAspectFit
//                })
//                (stackLike as! UIStackView).addArrangedSubview(
//                    UILabel(text: "Thích", textColor: Constant.text.color.black, font: nil), design: { (lbLike) -> (Void) in
//                        (lbLike as! UILabel).textAlignment = .center
//                })
//            })
//
//            (stackAction as! UIStackView).addArrangedSubview(UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .fill, spacing: 0, design: nil), design: { (stackLike) -> (Void) in
//                (stackLike as! UIStackView).addArrangedSubview(
//                    UIImageView(image: UIImage(named: "ic_like"), highlightedImage: nil), design: { (imvLike) -> (Void) in
//                        imvLike.tintColor = Constant.text.color.black
//                        imvLike.contentMode = .scaleAspectFit
//                })
//                (stackLike as! UIStackView).addArrangedSubview(
//                    UILabel(text: "Thích", textColor: Constant.text.color.black, font: nil), design: { (lbLike) -> (Void) in
//                        (lbLike as! UILabel).textAlignment = .center
//                })
//            })
//            (stackAction as! UIStackView).addArrangedSubview(
//                UILabel(text: "Thích", textColor: Constant.text.color.black, font: nil), design: { (lbLike) -> (Void) in
//                    (lbLike as! UILabel).textAlignment = .center
//            })
//            (stackAction as! UIStackView).addArrangedSubview(
//                UILabel(text: "Bình luận", textColor: Constant.text.color.black, font: nil), design: { (lbComment) -> (Void) in
//                    (lbComment as! UILabel).textAlignment = .center
//            })
        }
        
        stackNew.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        stackNew.isLayoutMarginsRelativeArrangement = true
        return stackNew
    }
}
