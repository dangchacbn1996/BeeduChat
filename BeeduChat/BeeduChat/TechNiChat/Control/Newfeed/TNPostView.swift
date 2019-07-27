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
    var emote : TNEmoji = .like
    var userName : String = ""
    var userAvatar : String = ""
}

class TNPostView {
    
    static func postView(_ post : TNPostInfoModel, isPin : Bool, actPin : UIGestureRecognizer?, actAvatar : UITapGestureRecognizer?, actLike : UIGestureRecognizer?, actEmoji : UITapGestureRecognizer?) -> (UIView){
        let newView = UIView()
        let stackNew = UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 4, design: nil)
        let stackHead = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)
        newView.addSubview(stackNew)
        stackNew.snp.makeConstraints { (maker) in
            maker.bottom.centerX.width.equalToSuperview()
            maker.top.equalToSuperview().offset(Constant.size.paddingView)
        }
        stackNew.addArrangedSubview(stackHead)
        stackHead.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal)
            maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
        }
        
        let avatar = UIButton()
        stackHead.addArrangedSubview(avatar)
        if (actAvatar != nil) {
            avatar.addGestureRecognizer(actAvatar!)
        }
        avatar.contentMode = .scaleAspectFill
        avatar.setImage(UIImage(named: post.userAvatar), for: .normal)
        avatar.snp.makeConstraints { (maker) in
            maker.width.equalTo(avatar.snp.height)
            maker.height.equalTo(Constant.size.avatarNormal)
        }
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = Constant.size.avatarNormal / 2
        
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
            (btnNote as! UIButton).setImage(UIImage(named: isPin ? "ic_pin_hover" : "ic_pin"), for: .normal)
            if (actPin != nil) {
                (btnNote as! UIButton).addGestureRecognizer(actPin!)
            }
            (btnNote as! UIButton).imageView?.contentMode = .scaleAspectFit
        }
        
        stackHead.addArrangedSubview(UIButton()) { (btnMore) -> (Void) in
            btnMore.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnMore.snp.height).multipliedBy(0.7)
                maker.width.equalTo(Constant.size.btnIcon)
            })
            (btnMore as! UIButton).setImage(UIImage(named: "ic_more_horizon"), for: .normal)
            (btnMore as! UIButton).imageView?.contentMode = .scaleAspectFit
        }
        
        stackNew.addArrangedSubview(stackHead)
        stackHead.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().offset(-Constant.size.paddingView)
        }
        
        stackNew.addArrangedSubview(UILabel(text: post.content, textColor: Constant.text.color.black, font: nil)) { (lbPreview) -> (Void) in
            (lbPreview as! UILabel).numberOfLines = 0
            lbPreview.snp.makeConstraints({ (maker) in
                maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
            })
            print("Line: \((lbPreview as! UILabel).calculateMaxLines())")
        }
        
        if (post.image.count > 0) {
//            let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:500))
//            let imageView = UIImageView()
//
//            if let image = UIImage(named: "a_image") {
//                let ratio = image.size.width / image.size.height
//                if containerView.frame.width > containerView.frame.height {
//                    let newHeight = containerView.frame.width / ratio
////                    imageView.frame.size = CGSize(width: containerView.frame.width, height: newHeight)
//                }
//                else{
//                    let newWidth = containerView.frame.height * ratio
////                    imageView.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
//                }
//            }
            stackNew.addArrangedSubview(UIImageView()) { (ivPreview) -> (Void) in
                let image = UIImage(named: post.image[0])!
                ivPreview.snp.makeConstraints({ (maker) in
                    maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
                    maker.height.equalTo(ivPreview.snp.width).multipliedBy(image.size.height / image.size.width)
                })
//                ivPreview.
                (ivPreview as! UIImageView).image = image
                ivPreview.contentMode = .scaleAspectFill
            }
        }
        
        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackLike) -> (Void) in
            stackLike.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.text.font.normal.lineHeight * 1.5)
                maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
            })
            if (actEmoji != nil) {
                stackLike.isUserInteractionEnabled = true
                stackLike.addGestureRecognizer(actEmoji!)
            }
            
            (stackLike as! UIStackView).addArrangedSubview(UIView(), design: { (viewLike) -> (Void) in
                viewLike.addSubview(UIImageView(image: UIImage(named: "emoji_like")), design: { (ivLike) -> (Void) in
                    ivLike.snp.makeConstraints({ (maker) in
                        maker.leading.centerY.equalToSuperview()
                        maker.height.equalToSuperview().multipliedBy(0.6)
                        maker.width.equalTo(ivLike.snp.height)
                    })
                    ivLike.contentMode = .scaleAspectFit
                })
                viewLike.addSubview(UIImageView(image: UIImage(named: "emoji_haha")), design: { (ivLike) -> (Void) in
                    ivLike.snp.makeConstraints({ (maker) in
                        maker.centerY.equalToSuperview()
                        maker.leading.equalTo(viewLike.subviews[0].snp.trailing).offset(-2)
                        maker.height.equalTo(viewLike.subviews[0].snp.height)
                        maker.width.equalTo(viewLike.subviews[0].snp.width)
                        //                        ivLike.widthAnchor.constraint(equalToConstant: ivLike.snp.height)
                    })
                    ivLike.contentMode = .scaleAspectFit
                })
                viewLike.addSubview(UIImageView(image: UIImage(named: "emoji_heart")), design: { (ivLike) -> (Void) in
                    ivLike.snp.makeConstraints({ (maker) in
                        maker.centerY.equalToSuperview()
                        maker.leading.equalTo(viewLike.subviews[1].snp.trailing).offset(-2)
                        maker.height.equalTo(viewLike.subviews[1].snp.height)
                        maker.width.equalTo(viewLike.subviews[1].snp.width)
                    })
                    ivLike.contentMode = .scaleAspectFit
                })
                viewLike.addSubview(
                    UILabel(text: "\(post.emotion.count)", textColor: Constant.text.color.black, font: nil), design: { (lb) -> (Void) in
                        lb.snp.makeConstraints({ (maker) in
                            maker.centerY.equalToSuperview()
                            maker.leading.equalTo(viewLike.subviews[2].snp.trailing).offset(4)
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
                maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
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
                maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
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
                    var icLike = UIImage(named: TNIcon.like.rawValue)
                    let label = UILabel(text: "Thích", textColor: Constant.text.color.gray, font: Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Medium))
                    for item in post.emotion {
                        if (item.userName == FixedData.user) {
                            label.font = Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Bold)
                            label.textColor = Constant.text.color.blue
                            if (item.emote == .like) {
                                icLike = UIImage(named: TNIcon.like_hover.rawValue)
                            } else {
                                icLike = UIImage(named: item.emote.rawValue)
                                switch item.emote {
                                case .angry:
                                    label.text = "Tức giận"
                                case .haha:
                                    label.text = "Haha"
                                case .heart:
                                    label.text = "Yêu thích"
                                case .cry:
                                    label.text = "Buồn"
                                default:
                                    label.text = "Thích"
                                }
                            }
                            break
                        }
                    }
                    (stackLike as! UIStackView).addArrangedSubview(UIImageView(image: icLike), design: { (imgLike) -> (Void) in
                        imgLike.snp.makeConstraints({ (maker) in
                            maker.width.equalTo(imgLike.snp.height)
                            maker.height.equalTo(Constant.text.font.normal.lineHeight)
                        })
                        imgLike.contentMode = .scaleAspectFit
                    })
                    
                    
                    (stackLike as! UIStackView).addArrangedSubview(label)
                    stackLike.isUserInteractionEnabled = true
                    if (actLike != nil) {
                        stackLike.addGestureRecognizer(actLike!)
                    }
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
                    (stackLike as! UIStackView).addArrangedSubview(UIImageView(image: UIImage(named: "ic_comment")?.withRenderingMode(.alwaysTemplate)), design: { (imgLike) -> (Void) in
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
    
    static func newPost(actAvatar : UIGestureRecognizer?, actNew : UIGestureRecognizer?, actPic : UIGestureRecognizer?) -> (UIView){
        let viewContainer = UIView()
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + Constant.size.paddingView)
        }
        
        let stackNew = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
        viewContainer.addSubview(stackNew)
        stackNew.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
        }
        stackNew.layoutMargins = UIEdgeInsets(top: 0, left: Constant.size.paddingView, bottom: 0, right: Constant.size.paddingView)
        stackNew.isLayoutMarginsRelativeArrangement = true
        
        let avatar = ReuseForms.btnAvatar()
        if (actAvatar != nil) {
            avatar.addGestureRecognizer(actAvatar!)
        }
        stackNew.addArrangedSubview(avatar)

        let buttonNew = UIButton(title: "Viết gì đó cho cả lớp", font: Constant.text.font.normal, titleColor: Constant.text.color.black, backColor: .clear, action: nil)
        stackNew.addArrangedSubview(buttonNew)
        if (actNew != nil) {
            buttonNew.addGestureRecognizer(actNew!)
        }
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
        if (actPic != nil) {
            btnLibrary.addGestureRecognizer(actPic!)
        }
        btnLibrary.setImage(UIImage(named: "ic_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnLibrary.imageView?.contentMode = .scaleAspectFit
        btnLibrary.tintColor = Constant.color.iconColor
        return viewContainer
    }
}
