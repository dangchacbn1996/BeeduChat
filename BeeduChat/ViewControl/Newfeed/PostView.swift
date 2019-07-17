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
    
    static func navigationView(lbTitle : UILabel, lbSubTitle : UILabel, btnMenu : UIButton, btnFunction : UIButton, btnMore : UIButton, actionMenu : UIGestureRecognizer?, actionNotifi : UIGestureRecognizer?, actionMore : UIGestureRecognizer?) -> (UIView){
        let navigationView = UIView(background: Constant.color.naviBack, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: UIColor.gray, design: nil)
        var naviConstraint : NSLayoutConstraint!
        naviConstraint = navigationView.heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
        naviConstraint.isActive = true
        
        /* Navigation
         **************************************
         * Menu         Class       noti more *
         **************************************
         */
        let infoView = UIView()
        navigationView.addSubview(infoView)
        infoView.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
        }
        infoView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)) { (stackNavi) -> (Void) in
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
            btnMenu.imageView?.contentMode = .scaleAspectFit
            if (actionMenu != nil) {
                btnMenu.addGestureRecognizer(actionMenu!)
            }
            //            self.btnMenu.backgroundColor = UIColor.blue
            
            //Ten lop
            (stackNavi as! UIStackView).addArrangedSubview(UIView())
            
            infoView.addSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil), design: { (stackClass) -> (Void) in
                stackClass.snp.makeConstraints({ (maker) in
                    maker.center.equalToSuperview()
                    
                })
                (stackClass as! UIStackView).addArrangedSubview(lbTitle)
                (stackClass as! UIStackView).addArrangedSubview(lbSubTitle)
            })
            
            //Btn noti
            (stackNavi as! UIStackView).addArrangedSubview(btnFunction)
            btnFunction.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnFunction.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            btnFunction.setImage(UIImage(named: "ic_noti")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnFunction.tintColor = Constant.color.iconColor
            btnFunction.imageView?.contentMode = .scaleAspectFit
            if (actionNotifi != nil) {
                btnFunction.addGestureRecognizer(actionNotifi!)
            }
            
            //Btn more
            (stackNavi as! UIStackView).addArrangedSubview(btnMore)
            btnMore.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnMore.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            btnMore.setImage(UIImage(named: "ic_more")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnMore.tintColor = Constant.color.iconColor
            btnMore.imageView?.contentMode = .scaleAspectFit
            if (actionMore != nil) {
                btnMore.addGestureRecognizer(actionMore!)
            }
        }
        
        /* Separate
         **************************************
         */
        navigationView.addSubview(UIView()) { (separate) -> (Void) in
            separate.snp.makeConstraints({ (maker) in
                maker.centerX.width.equalToSuperview()
                maker.bottom.equalTo(navigationView.snp.bottom)
                maker.height.equalTo(Constant.size.separatorHeight)
            })
            separate.backgroundColor = Constant.color.separate
        }
        
        return navigationView
    }
    
    static func postInfo() -> (UIView){
        let newView = UIView()
        let stackNew = UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 4, design: nil)
        let stackHead = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)
        newView.addSubview(stackNew)
        stackNew.snp.makeConstraints { (maker) in
            maker.bottom.centerX.width.equalToSuperview()
            maker.top.equalToSuperview().offset(16)
        }
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
                    maker.width.equalTo(Constant.size.separatorHeight)
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
                maker.height.equalTo(Constant.size.separatorHeight)
                maker.width.equalToSuperview().offset(-16)
            })
            separate.backgroundColor = Constant.color.separate
        }
        
        stackNew.addArrangedSubview(UIView()) { (separator) -> (Void) in
            separator.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.size.separatorHeight)
            })
            separator.backgroundColor = Constant.color.separate
        }
        
        stackNew.addArrangedSubview(UIView()) { (viewAction) -> (Void) in
            viewAction.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.text.font.normal.lineHeight * 1.5)
                maker.width.equalToSuperview().offset(-16)
            })
            viewAction.addSubview(UIView(), design: { (viewLike) -> (Void) in
                viewLike.snp.makeConstraints({ (maker) in
                    maker.leading.top.bottom.equalToSuperview()
                    maker.width.equalToSuperview().multipliedBy(0.5)
                })
                viewLike.addSubview(UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: 4, design: nil), design: { (stackLike) -> (Void) in
                    stackLike.snp.makeConstraints({ (maker) in
                        maker.center.equalToSuperview()
                        maker.height.lessThanOrEqualToSuperview()
                    })
                    (stackLike as! UIStackView).addArrangedSubview(UIImageView(image: UIImage(named: "ic_like")?.withRenderingMode(.alwaysTemplate)), design: { (imgLike) -> (Void) in
                        imgLike.snp.makeConstraints({ (maker) in
                            maker.height.equalTo(Constant.text.font.normal.lineHeight)
                        })
                        imgLike.tintColor = Constant.text.color.gray
                        imgLike.contentMode = .scaleAspectFit
                    })
                    (stackLike as! UIStackView).addArrangedSubview(UILabel(text: "Thích", textColor: Constant.text.color.gray, font: Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Medium)))
                })
            })
//            viewAction.addSubview(UIView(), design: { (separator) -> (Void) in
//                separator.backgroundColor = Constant.color.separate
//                separator.snp.makeConstraints({ (maker) in
//                    maker.height.equalToSuperview().multipliedBy(0.8)
//                    maker.width.equalTo(Constant.size.separatorHeight)
//                    maker.center.equalToSuperview()
//                })
//            })
            viewAction.addSubview(UIView(), design: { (viewLike) -> (Void) in
                viewLike.snp.makeConstraints({ (maker) in
                    maker.trailing.top.bottom.equalToSuperview()
                    maker.width.equalToSuperview().multipliedBy(0.5)
                })
                viewLike.addSubview(UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: 4, design: nil), design: { (stackLike) -> (Void) in
                    stackLike.snp.makeConstraints({ (maker) in
                        maker.center.equalToSuperview()
                        maker.height.lessThanOrEqualToSuperview()
                    })
                    (stackLike as! UIStackView).addArrangedSubview(UIImageView(image: UIImage(named: "ic_comment")?.withRenderingMode(.alwaysTemplate)), design: { (imgLike) -> (Void) in
                        imgLike.snp.makeConstraints({ (maker) in
                            maker.height.equalTo(Constant.text.font.normal.lineHeight)
                        })
                        imgLike.tintColor = Constant.text.color.gray
                        imgLike.contentMode = .scaleAspectFit
                    })
                    (stackLike as! UIStackView).addArrangedSubview(UILabel(text: "Bình luận", textColor: Constant.text.color.gray, font: Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Medium)))
                })
            })
        }
        return newView
    }
    
    static func newPost() -> (UIView){
        let stackNew = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
        let avatar = ReuseForms.btnAvatar()
        let tfNew = UITextField(text: "", placeholder: "Viết gì đó cho cả lớp", textColor: Constant.text.color.black, font: nil)
//        let tvNew = UITextView()
        let btnLibrary = UIButton()
        let viewContainer = UIView()
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 32)
        }
        viewContainer.addSubview(stackNew)
        stackNew.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
        }
        stackNew.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackNew.isLayoutMarginsRelativeArrangement = true
        stackNew.addArrangedSubview(UIView()) { (viewAvatar) -> (Void) in
            viewAvatar.snp.makeConstraints({ (maker) in
                maker.width.equalTo(Constant.size.avatarNormal)
                maker.height.equalToSuperview().offset(-16)
            })
            viewAvatar.addSubview(avatar)
            avatar.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.equalToSuperview()
            })
        }
        
        stackNew.addArrangedSubview(tfNew)
        //        tvNew.textColor = Constant.text.color.black
        //
        //        tvNew.text = "Viết gì đó cho cả lớp"
        //        tfNew.
        //        stackNew.snp.makeConstraints { (maker) in
        //            maker.height.greaterThanOrEqualTo(self.tvNew.snp.height)
        //        }
        
        stackNew.addArrangedSubview(UIView()) { (viewLib) -> (Void) in
            viewLib.snp.makeConstraints({ (maker) in
                maker.width.equalTo(stackNew.subviews[0].snp.width).multipliedBy(0.7)
                maker.height.equalToSuperview().offset(-32)
            })
            viewLib.addSubview(btnLibrary)
            btnLibrary.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.equalToSuperview()
                maker.height.equalTo(Constant.size.iconNormal)
            })
            btnLibrary.contentMode = .scaleAspectFit
            btnLibrary.setImage(UIImage(named: "ic_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnLibrary.tintColor = Constant.color.iconColor
        }
        return viewContainer
    }
}
