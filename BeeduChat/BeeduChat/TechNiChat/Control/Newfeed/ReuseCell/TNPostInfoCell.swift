//
//  NewPostCell.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/13/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol TNPostInfoDelegate {
    @objc func actPostAvatar(_ gesture : UIGestureRecognizer)
    @objc func actPostPin(_ gesture : UIGestureRecognizer)
//    @objc func actPostMore(_ gesture : UIGestureRecognizer)
//    @objc func actPostImageView(_ gesture : UIGestureRecognizer)
    @objc func actPostEmoji(_ gesture : UIGestureRecognizer)
    @objc func actPostEmotion(_ gesture : UIGestureRecognizer)
    
}

class TNPostInfoCell : UITableViewCell {
    
    static let identify = "TNPostInfoCell"
    private let stackNew = UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 4, design: nil)
    private let stackHead = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)
    private let ivAvatar = UIButton()
    private let lbUserName = UILabel(text: "",
                                     textColor: Constant.text.color.black,
                                     font: Constant.text.font.customFont(
                                        size: Constant.text.size.normal,
                                        weight: .Bold))
    private let lbClass = UILabel(text: "", textColor: Constant.text.color.gray, font: Constant.text.font.small)
    private let lbTimePost = UILabel(text: "", textColor: Constant.text.color.gray, font: Constant.text.font.small)
    private let btnPin = UIButton()
    private let btnMore = UIButton()
    private let lbContent = UILabel(text: "", textColor: Constant.text.color.black, font: nil)
    private let ivContent = UIImageView()
//    private let stackEmoji = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: -4, design: nil)
    private let vEmote = UIView()
    private let lbEmojiCount = UILabel(text: "", textColor: Constant.text.color.black, font: nil)
    private let lbComment = UILabel(text: "", textColor: Constant.text.color.black, font: nil)
    private let lbSeenPer = UILabel(text: "", textColor: Constant.text.color.black, font: nil)
    private let viewEmoji = UIView()
    private let lbEmotion = UILabel(text: "Thích", textColor: Constant.text.color.black, font: nil)
    private let ivEmotion = UIImageView(image: UIImage(named: "ic_like"))
    private let viewEmotion = UIView()
    var delegate : TNPostInfoDelegate? = nil {
        didSet{
            ivAvatar.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostAvatar(_:))))
            btnPin.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostPin(_:))))
            viewEmoji.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostEmoji(_:))))
            viewEmotion.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostEmotion(_:))))
        }
    }
    
    var isPin = false {
        didSet {
            btnPin.setImage(UIImage(named: isPin ? "ic_pin_hover" : "ic_pin"), for: .normal)
        }
    }
    
    var data : TNPostInfoModel = TNPostInfoModel() {
        didSet {
            ivAvatar.setImage(UIImage(named: data.userAvatar), for: .normal)
            lbUserName.text = data.username
            lbClass.text = data.eduClass
            lbTimePost.text = data.timePosted
            lbContent.text = data.content
            if (data.image.count > 0) {
                let image = UIImage(named: data.image[0])!
                ivContent.snp.makeConstraints({ (maker) in
                    maker.height.equalTo(ivContent.snp.width).multipliedBy(image.size.height / image.size.width)
                })
                ivContent.isHidden = false
                ivContent.image = image
            } else {
                ivContent.isHidden = true
//                ivContent.snp.makeConstraints { (maker) in
//                    maker.height.equalTo(0)
//                }
            }
            ivEmotion.image = UIImage(named: TNIcon.like.rawValue)?.withRenderingMode(.alwaysTemplate)
            lbEmotion.text = "Thích"
            lbEmotion.font = Constant.text.font.normal
            lbEmotion.textColor = Constant.text.color.gray
            for item in data.emotion {
                if (item.userName == FixedData.user) {
                    lbEmotion.font = Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Bold)
                    if (item.emote == .like) {
                        ivEmotion.image = UIImage(named: TNIcon.like_hover.rawValue)
                        lbEmotion.textColor = Constant.text.color.blue
                    } else {
                        ivEmotion.image = UIImage(named: item.emote.rawValue)
                        switch item.emote {
                        case .angry:
                            lbEmotion.textColor = Constant.text.color.angry
                            lbEmotion.text = "Tức giận"
                        case .wow:
                            lbEmotion.textColor = Constant.text.color.emote
                            lbEmotion.text = "Wow"
                        case .haha:
                            lbEmotion.textColor = Constant.text.color.emote
                            lbEmotion.text = "Haha"
                        case .heart:
                            lbEmotion.textColor = Constant.text.color.heart
                            lbEmotion.text = "Yêu thích"
                        case .cry:
                            lbEmotion.textColor = Constant.text.color.emote
                            lbEmotion.text = "Buồn"
                        default:
                            lbEmotion.textColor = Constant.text.color.blue
                            lbEmotion.text = "Thích"
                        }
                    }
                    break
                }
            }
            vEmote.subviews.forEach({$0.removeFromSuperview()})
            if (data.emotion.count > 0) {
                lbEmojiCount.text = "\(data.emotion.count)"
                var haveLike = false
                var curEmoji : TNEmoji? = nil
                var nextEmoji : TNEmoji? = nil
                var lastEmoji : TNEmoji? = nil
                for emoji in data.emotion {
                    if (emoji.emote == .like) {
                        haveLike = true
                    } else if (nextEmoji == nil) {
                        nextEmoji = emoji.emote
                    } else if emoji.emote != nextEmoji {
                        lastEmoji = emoji.emote
                    } else if emoji.emote != lastEmoji {
                        curEmoji = emoji.emote
                        break
                    }
                }
                if (haveLike) {
                    vEmote.addSubview(UIImageView(image: UIImage(named: "emoji_like")), design: { (ivLike) -> (Void) in
                        ivLike.contentMode = .scaleAspectFit
                        ivLike.snp.makeConstraints({ (maker) in
                            maker.height.equalToSuperview().multipliedBy(0.7)
                            maker.centerY.equalToSuperview()
                            maker.width.equalTo(ivLike.snp.height)
                            maker.leading.equalToSuperview()
                        })
                    })
                } else  if (curEmoji != nil) {
                    vEmote.addSubview(UIImageView(image: UIImage(named: curEmoji!.rawValue)), design: { (ivLike) -> (Void) in
                        ivLike.contentMode = .scaleAspectFit
                        ivLike.snp.makeConstraints({ (maker) in
                            maker.height.equalToSuperview().multipliedBy(0.7)
                            maker.centerY.equalToSuperview()
                            maker.width.equalTo(ivLike.snp.height)
                            maker.leading.equalToSuperview()
                        })
                    })
                }
                if (nextEmoji != nil) {
                    let nextEmote = UIImageView(image: UIImage(named: nextEmoji!.rawValue))
                    nextEmote.contentMode = .scaleAspectFit
                    vEmote.addSubview(nextEmote)
                    nextEmote.snp.makeConstraints({ (maker) in
                        maker.height.equalToSuperview().multipliedBy(0.7)
                        maker.centerY.equalToSuperview()
                        maker.width.equalTo(nextEmote.snp.height)
                        if (haveLike || curEmoji != nil) {
                            maker.leading.equalTo(vEmote.subviews[0].snp.trailing).offset(-4)
                        } else {
                            maker.leading.equalToSuperview()
                        }
                    })
                    if (lastEmoji != nil) {
                        vEmote.addSubview(UIImageView(image: UIImage(named: lastEmoji!.rawValue)), design: { (ivEmote) -> (Void) in
                            ivEmote.contentMode = .scaleAspectFit
                            ivEmote.snp.makeConstraints({ (maker) in
                                maker.height.equalToSuperview().multipliedBy(0.7)
                                maker.width.equalTo(ivEmote.snp.height)
                                maker.centerY.equalToSuperview()
                                maker.leading.equalTo(nextEmote.snp.trailing).offset(-4)
                                maker.trailing.equalToSuperview()
                            })
                        })
                    } else {
                        nextEmote.snp.makeConstraints { (maker) in
                            maker.trailing.equalToSuperview()
                        }
                    }
                } else {
                    vEmote.subviews[0].snp.makeConstraints { (maker) in
                        maker.trailing.equalToSuperview()
                    }
                }
            } else {
                viewEmoji.isHidden = true
            }
            var commentCount = 0
            for item in data.comment {
                commentCount += 1
                commentCount += item.answer.count
            }
            lbComment.text = "\(commentCount) bình luận"
            lbSeenPer.text = "\(data.viewCount) lượt xem"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI(){
        self.addSubview(stackNew)
        stackNew.snp.makeConstraints { (maker) in
            maker.bottom.centerX.width.equalToSuperview()
            maker.top.equalToSuperview().offset(Constant.size.paddingView)
        }
        stackNew.addArrangedSubview(stackHead)
        stackHead.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal)
            maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
        }
        
        stackHead.addArrangedSubview(ivAvatar)
//        if (actAvatar != nil) {
//            avatar.addGestureRecognizer(actAvatar!)
//        }
        ivAvatar.contentMode = .scaleAspectFill

        ivAvatar.snp.makeConstraints { (maker) in
            maker.width.equalTo(self.ivAvatar.snp.height)
            maker.height.equalTo(Constant.size.avatarNormal)
        }
        ivAvatar.clipsToBounds = true
        ivAvatar.layer.cornerRadius = Constant.size.avatarNormal / 2
        
        stackHead.addArrangedSubview(UIView()) { (viewInfo) -> (Void) in
            viewInfo.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview()
            })
            //0
            viewInfo.addSubview(
                self.lbUserName,
                design: {
                    (lbUser) -> (Void) in
                    lbUser.snp.makeConstraints({ (maker) in
                    maker.top.trailing.equalToSuperview()
                    maker.leading.equalToSuperview().offset(4)
                    maker.height.equalTo(Constant.size.avatarNormal / 2)
                })
            })
            //1
            viewInfo.addSubview(self.lbClass)
            self.lbClass.snp.makeConstraints({ (maker) in
                maker.leading.equalTo(viewInfo.subviews[0].snp.leading)
                maker.height.equalTo(Constant.size.avatarNormal / 2)
                maker.top.equalTo(viewInfo.subviews[0].snp.bottom)
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
            viewInfo.addSubview(self.lbTimePost)
            self.lbTimePost.snp.makeConstraints({ (maker) in
                maker.leading.equalTo(viewInfo.subviews[2].snp.trailing).offset(4)
                maker.centerY.height.equalTo(viewInfo.subviews[1])
            })
        }
        
        stackHead.addArrangedSubview(btnPin)
        btnPin.imageView?.contentMode = .scaleAspectFit
        btnPin.snp.makeConstraints({ (maker) in
            maker.width.equalTo(btnPin.snp.height).multipliedBy(0.5)
            maker.width.equalTo(Constant.size.btnIcon)
        })
        
        stackHead.addArrangedSubview(btnMore)
        btnMore.setImage(UIImage(named: "ic_more_horizon"), for: .normal)
        btnMore.imageView?.contentMode = .scaleAspectFit
        btnMore.snp.makeConstraints({ (maker) in
            maker.width.equalTo(btnMore.snp.height).multipliedBy(0.7)
            maker.width.equalTo(Constant.size.btnIcon)
        })
        
        stackNew.addArrangedSubview(stackHead)
        stackHead.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().offset(-Constant.size.paddingView)
        }
        
        stackNew.addArrangedSubview(lbContent)
        lbContent.numberOfLines = 0
        lbContent.snp.makeConstraints({ (maker) in
            maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
        })
        
        stackNew.addArrangedSubview(ivContent)
        ivContent.contentMode = .scaleAspectFill
        ivContent.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
//            maker.height.equalTo(0)
        }

        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackLike) -> (Void) in
            stackLike.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.text.font.normal.lineHeight * 1.5)
                maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
            })
            
            (stackLike as! UIStackView).addArrangedSubview(self.viewEmoji)
            self.viewEmoji.addSubview(self.vEmote)
            self.vEmote.isUserInteractionEnabled = true
            self.vEmote.snp.makeConstraints({ (maker) in
                maker.left.centerY.equalToSuperview()
                maker.right.height.lessThanOrEqualToSuperview()
            })
            
            self.viewEmoji.addSubview(self.lbEmojiCount)
            self.lbEmojiCount.snp.makeConstraints({ (maker) in
                maker.centerY.height.equalToSuperview()
                maker.trailing.lessThanOrEqualToSuperview()
                maker.leading.equalTo(self.vEmote.snp.trailing).offset(4)
            })
            
            (stackLike as! UIStackView).addArrangedSubview(self.lbComment)
            (stackLike as! UIStackView).addArrangedSubview(self.lbSeenPer)
        }
        
        stackNew.addArrangedSubview(UIView()) { (separate) -> (Void) in
            separate.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.size.separatorHeight)
                maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
            })
            separate.backgroundColor = Constant.color.separate
        }
        
        //Thichs            Binhf luan
        stackNew.addArrangedSubview(UIView()) { (viewAction) -> (Void) in
            viewAction.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.text.font.normal.lineHeight * 1.5)
                maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
            })
            viewAction.addSubview(self.viewEmotion)
            self.viewEmotion.isUserInteractionEnabled = true
            self.viewEmotion.snp.makeConstraints({ (maker) in
                maker.leading.top.bottom.equalToSuperview()
                maker.width.equalToSuperview().multipliedBy(0.5)
            })
            self.viewEmotion.addSubview(UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: 4, design: nil), design: { (stackLike) -> (Void) in
                stackLike.snp.makeConstraints({ (maker) in
                    maker.center.equalToSuperview()
                    maker.height.lessThanOrEqualToSuperview()
                })
                (stackLike as! UIStackView).addArrangedSubview(self.ivEmotion)
                
                self.ivEmotion.snp.makeConstraints({ (maker) in
                    maker.width.equalTo(self.ivEmotion.snp.height)
                    maker.height.equalTo(Constant.text.font.normal.lineHeight)
                })
                self.ivEmotion.tintColor = Constant.text.color.gray
                self.ivEmotion.contentMode = .scaleAspectFit
                
                (stackLike as! UIStackView).addArrangedSubview(self.lbEmotion)
                stackLike.isUserInteractionEnabled = true
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
        stackNew.addArrangedSubview(UIView()) { (separator) -> (Void) in
            separator.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.size.separatorHeight)
                maker.width.equalToSuperview()
            })
            separator.backgroundColor = Constant.color.separate
        }
    }
}
