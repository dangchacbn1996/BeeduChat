//
//  PostView.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/13/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import Foundation
import SnapKit

struct TNPostInfoModel {
    var userId : String = "123"
    var username : String = "user"
    var eduClass : String = ""
    var timePosted : String = ""
    var userAvatar : String = ""
    var content : String = ""
    var image : [String] = []
    var viewCount : Int = 0
    var emotion : [TNEmotionModel] = []
    var comment : [TNCommentModel] = []
}

struct TNEmotionModel {
    var emote : String = ""
    var userName : String = ""
    var userAvatar : String = ""
}

class TNPostView {
    
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
                maker.width.equalTo(Constant.size.btnIcon)
            })
            (btnNote as! UIButton).setImage(UIImage(named: "ic_star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            (btnNote as! UIButton).tintColor = Constant.color.btnTitle
            (btnNote as! UIButton).imageView?.contentMode = .scaleAspectFit
        }
        
        stackHead.addArrangedSubview(UIButton()) { (btnMore) -> (Void) in
            btnMore.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnMore.snp.height).multipliedBy(0.7)
                maker.width.equalTo(Constant.size.btnIcon)
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
            ivPreview.contentMode = .scaleAspectFill
        }
        
        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackLike) -> (Void) in
            stackLike.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.text.font.normal.lineHeight * 1.5)
                maker.width.equalToSuperview().offset(-16)
            })
            
            (stackLike as! UIStackView).addArrangedSubview(UIView(), design: { (viewLike) -> (Void) in
//                viewLike.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                viewLike.addSubview(
                    UILabel(text: "😄🤣❤️ 16", textColor: Constant.text.color.black, font: nil), design: { (lb) -> (Void) in
                        lb.snp.makeConstraints({ (maker) in
                            maker.leading.centerY.equalToSuperview()
                            maker.height.lessThanOrEqualToSuperview()
                        })
                })
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
                            maker.width.equalTo(imgLike.snp.height)
                            maker.height.equalTo(Constant.text.font.normal.lineHeight)
                        })
                        imgLike.tintColor = Constant.text.color.gray
                        imgLike.contentMode = .scaleAspectFit
                    })
                    (stackLike as! UIStackView).addArrangedSubview(UILabel(text: "Thích", textColor: Constant.text.color.gray, font: Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Medium)))
                })
            })
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
                    (stackLike as! UIStackView).addArrangedSubview(UIImageView(image: UIImage(named: "ic_comment-1")?.withRenderingMode(.alwaysTemplate)), design: { (imgLike) -> (Void) in
                        imgLike.snp.makeConstraints({ (maker) in
                            maker.width.equalTo(imgLike.snp.height)
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
    
    static func postView(_ post : TNPostInfoModel) -> (UIView){
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
            viewInfo.addSubview(UILabel(text: post.username,
                                        textColor: Constant.text.color.black,
                                        font: Constant.text.font.customFont(
                                            size: Constant.text.size.normal,
                                            weight: .Bold)), design: { (lbUser) -> (Void) in
                lbUser.snp.makeConstraints({ (maker) in
                    maker.top.trailing.equalToSuperview()
                    maker.leading.equalToSuperview().offset(4)
                    maker.height.equalTo(Constant.size.avatarNormal / 2)
                })
            })
            //1
            viewInfo.addSubview(UILabel(text: post.eduClass, textColor: Constant.text.color.gray, font: Constant.text.font.small), design: { (lbClass) -> (Void) in
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
            viewInfo.addSubview(UILabel(text: post.timePosted, textColor: Constant.text.color.gray, font: Constant.text.font.small), design: { (lbClass) -> (Void) in
                lbClass.snp.makeConstraints({ (maker) in
                    maker.leading.equalTo(viewInfo.subviews[2].snp.trailing).offset(4)
                    maker.centerY.height.equalTo(viewInfo.subviews[1])
                })
            })
        }
        
        stackHead.addArrangedSubview(UIButton()) { (btnNote) -> (Void) in
            btnNote.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnNote.snp.height).multipliedBy(0.7)
                maker.width.equalTo(Constant.size.btnIcon)
            })
            (btnNote as! UIButton).setImage(UIImage(named: "ic_star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            (btnNote as! UIButton).tintColor = Constant.color.btnTitle
            (btnNote as! UIButton).imageView?.contentMode = .scaleAspectFit
        }
        
        stackHead.addArrangedSubview(UIButton()) { (btnMore) -> (Void) in
            btnMore.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnMore.snp.height).multipliedBy(0.7)
                maker.width.equalTo(Constant.size.btnIcon)
            })
            (btnMore as! UIButton).setImage(UIImage(named: "ic_more_horizon")?.withRenderingMode(.alwaysTemplate), for: .normal)
            (btnMore as! UIButton).tintColor = Constant.color.iconColor
            (btnMore as! UIButton).imageView?.contentMode = .scaleAspectFit
        }
        
        stackNew.addArrangedSubview(stackHead)
        stackHead.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().offset(-16)
        }
        
        stackNew.addArrangedSubview(UILabel(text: post.content, textColor: Constant.text.color.black, font: nil)) { (lbPreview) -> (Void) in
            (lbPreview as! UILabel).numberOfLines = 0
            lbPreview.snp.makeConstraints({ (maker) in
                maker.width.equalToSuperview().offset(-16)
            })
        }
        
        if (post.image.count > 0) {
            stackNew.addArrangedSubview(UIImageView()) { (ivPreview) -> (Void) in
                ivPreview.snp.makeConstraints({ (maker) in
                    maker.width.equalToSuperview()
                    maker.height.equalTo(ivPreview.snp.width).multipliedBy(0.75)
                })
                (ivPreview as! UIImageView).image = UIImage(named: post.image[0])
                ivPreview.contentMode = .scaleAspectFill
            }
        }
        
        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackLike) -> (Void) in
            stackLike.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.text.font.normal.lineHeight * 1.5)
                maker.width.equalToSuperview().offset(-16)
            })
            
            (stackLike as! UIStackView).addArrangedSubview(UIView(), design: { (viewLike) -> (Void) in
                //                viewLike.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                viewLike.addSubview(
                    UILabel(text: "😄🤣❤️ \(post.emotion.count)", textColor: Constant.text.color.black, font: nil), design: { (lb) -> (Void) in
                        lb.snp.makeConstraints({ (maker) in
                            maker.leading.centerY.equalToSuperview()
                            maker.height.lessThanOrEqualToSuperview()
                        })
                })
            })
            var commentCount = 0
            for item in post.comment {
                commentCount += 1
                commentCount += item.answer.count
            }
            (stackLike as! UIStackView).addArrangedSubview(
                UILabel(text: "\(commentCount) bình luận", textColor: Constant.text.color.black, font: nil), design: { (viewLike) -> (Void) in
            })
            (stackLike as! UIStackView).addArrangedSubview(
                UILabel(text: "\(post.viewCount) lượt xem", textColor: Constant.text.color.black, font: nil), design: { (viewLike) -> (Void) in
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
                            maker.width.equalTo(imgLike.snp.height)
                            maker.height.equalTo(Constant.text.font.normal.lineHeight)
                        })
                        imgLike.tintColor = Constant.text.color.gray
                        imgLike.contentMode = .scaleAspectFit
                    })
                    (stackLike as! UIStackView).addArrangedSubview(UILabel(text: "Thích", textColor: Constant.text.color.gray, font: Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Medium)))
                })
            })
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
                    (stackLike as! UIStackView).addArrangedSubview(UIImageView(image: UIImage(named: "ic_comment-1")?.withRenderingMode(.alwaysTemplate)), design: { (imgLike) -> (Void) in
                        imgLike.snp.makeConstraints({ (maker) in
                            maker.width.equalTo(imgLike.snp.height)
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
        let viewContainer = UIView()
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 16)
        }
        
        let stackNew = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
        viewContainer.addSubview(stackNew)
        stackNew.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
        }
        stackNew.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        stackNew.isLayoutMarginsRelativeArrangement = true
        
        let avatar = ReuseForms.btnAvatar()
        stackNew.addArrangedSubview(avatar)

        let buttonNew = UIButton(title: "Viết gì đó cho cả lớp", font: Constant.text.font.normal, titleColor: Constant.text.color.black, backColor: .clear, action: nil)
        stackNew.addArrangedSubview(buttonNew)
        buttonNew.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
        }
        
        stackNew.addArrangedSubview(UIView())
        
        let btnLibrary = UIButton()
        stackNew.addArrangedSubview(btnLibrary)
        btnLibrary.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.btnIcon)
            maker.width.equalTo(btnLibrary.snp.height)
        }
        btnLibrary.setImage(UIImage(named: "ic_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnLibrary.imageView?.contentMode = .scaleAspectFit
        btnLibrary.tintColor = Constant.color.iconColor
        return viewContainer
    }
}
