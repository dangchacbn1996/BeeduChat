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
    @objc func actPostMore(_ gesture : UIGestureRecognizer)
    @objc func actPostImageView(_ gesture : UIGestureRecognizer)
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
    private var vSeparate = UIView()
    var hideSeparate = false {
        didSet{
            vSeparate.snp.makeConstraints { (maker) in
                maker.height.equalTo(self.hideSeparate ? 0 : Constant.size.paddingView)
            }
        }
    }
    var hideUserInfo = false {
        didSet {
            stackHead.isHidden = self.hideUserInfo
        }
    }
    var delegate : TNPostInfoDelegate? = nil {
        didSet{
            ivAvatar.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostAvatar(_:))))
            btnPin.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostPin(_:))))
            viewEmoji.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostEmoji(_:))))
            viewEmotion.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostEmotion(_:))))
            ivContent.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostImageView(_:))))
            btnMore.addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(self.delegate?.actPostMore(_:))))
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
                    maker.height.equalTo(ivContent.snp.width).multipliedBy(0.6)
                })
                ivContent.isHidden = false
                let width : Double = Double(self.frame.width - 2 * Constant.size.paddingView)
                ivContent.image = image.crop(to: CGSize(width: width, height: width * 0.6))
            } else {
                ivContent.isHidden = true
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
            viewEmoji.isHidden = true
            if (data.emotion.count > 0) {
                viewEmoji.isHidden = false
                lbEmojiCount.text = "\(data.emotion.count)"
                var haveLike = false
                var firstEmoji : TNEmoji? = nil
                var secondEmoji : TNEmoji? = nil
                var thirdEmoji : TNEmoji? = nil
                for emoji in data.emotion {
                    if (emoji.emote == .like) {
                        haveLike = true
                    } else if (secondEmoji == nil) {
                        secondEmoji = emoji.emote
                    } else if emoji.emote != secondEmoji {
                        thirdEmoji = emoji.emote
                    } else if emoji.emote != thirdEmoji {
                        firstEmoji = emoji.emote
                        break
                    }
                }
                
                var firstEmote : UIImageView? = nil
                var secondEmote : UIImageView? = nil
                var thirdEmote : UIImageView? = nil
                
                if (haveLike) {
                    firstEmote = UIImageView(image: UIImage(named: "emoji_like"))
                } else if (firstEmoji != nil) {
                    firstEmote = UIImageView(image: UIImage(named: firstEmoji!.rawValue))
                }
                
                if (thirdEmoji != nil) {
                    thirdEmote = UIImageView(image: UIImage(named: thirdEmoji!.rawValue))
                    thirdEmote!.contentMode = .scaleAspectFit
                    vEmote.addSubview(thirdEmote!)
                    thirdEmote?.layer.cornerRadius = 10
                    thirdEmote?.clipsToBounds = true
                    thirdEmote?.layer.borderColor = UIColor.white.cgColor
                    thirdEmote?.layer.borderWidth = 1
                    thirdEmote!.snp.makeConstraints({ (maker) in
                        maker.height.equalTo(20)
                        maker.centerY.equalToSuperview()
                        maker.width.equalTo(thirdEmote!.snp.height)
                        maker.trailing.equalToSuperview()
                    })
                }
                
                if (secondEmoji != nil) {
                    secondEmote = UIImageView(image: UIImage(named: secondEmoji!.rawValue))
                    secondEmote!.contentMode = .scaleAspectFit
                    vEmote.addSubview(secondEmote!)
                    secondEmote?.layer.cornerRadius = 10
                    secondEmote?.clipsToBounds = true
                    secondEmote?.layer.borderColor = UIColor.white.cgColor
                    secondEmote?.layer.borderWidth = 1
                    secondEmote!.snp.makeConstraints({ (maker) in
                        maker.height.equalTo(20)
                        maker.centerY.equalToSuperview()
                        maker.width.equalTo(secondEmote!.snp.height)
                        if (thirdEmote != nil) {
                            maker.trailing.equalTo(thirdEmote!.snp.leading).offset(4)
                        } else {
                            maker.trailing.equalToSuperview()
                        }
                        if (firstEmote == nil) {
                            maker.leading.equalToSuperview()
                        }
                    })
                }
                
                if (firstEmote != nil) {
                    firstEmote?.contentMode = .scaleAspectFit
                    vEmote.addSubview(firstEmote!)
                    firstEmote?.layer.cornerRadius = 10
                    firstEmote?.clipsToBounds = true
                    firstEmote?.layer.borderColor = UIColor.white.cgColor
                    firstEmote?.layer.borderWidth = 1
                    firstEmote!.snp.makeConstraints({ (maker) in
                        maker.height.equalTo(20)
                        maker.centerY.equalToSuperview()
                        maker.width.equalTo(firstEmote!.snp.height)
                        maker.leading.equalToSuperview()
                        if (secondEmote != nil) {
                            maker.trailing.equalTo(secondEmote!.snp.leading).offset(4)
                        } else {
                            maker.trailing.equalToSuperview()
                        }
                    })
                }
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
        self.addSubview(vSeparate)
        self.addSubview(stackNew)
        vSeparate.backgroundColor = Constant.color.separateNewFeed
        vSeparate.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.paddingView)
            maker.top.centerX.width.equalToSuperview()
        }
        stackNew.snp.makeConstraints { (maker) in
            maker.bottom.centerX.width.equalToSuperview()
            maker.top.equalTo(vSeparate.snp.bottom).offset(Constant.size.paddingView)
        }
        stackNew.addArrangedSubview(stackHead)
        stackHead.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal)
            maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
        }
        
        stackHead.addArrangedSubview(ivAvatar)
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
            viewInfo.addSubview(self.lbClass)
            self.lbClass.snp.makeConstraints({ (maker) in
                maker.leading.equalTo(viewInfo.subviews[0].snp.leading)
                maker.height.equalTo(Constant.size.avatarNormal / 2)
                maker.top.equalTo(viewInfo.subviews[0].snp.bottom)
            })
            viewInfo.addSubview(UIView(), design: { (separate) -> (Void) in
                separate.backgroundColor = Constant.color.separate
                separate.snp.makeConstraints({ (maker) in
                    maker.width.equalTo(Constant.size.separatorHeight)
                    maker.leading.equalTo(viewInfo.subviews[1].snp.trailing).offset(4)
                    maker.centerY.equalTo(viewInfo.subviews[1].snp.centerY)
                    maker.height.equalTo((viewInfo.subviews[1] as! UILabel).font.lineHeight)
                })
            })
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
        
        //Content
        //ImageContent
        stackNew.addArrangedSubview(lbContent)
        lbContent.numberOfLines = 0
        lbContent.snp.makeConstraints({ (maker) in
            maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
        })
        
        stackNew.addArrangedSubview(ivContent)
        ivContent.contentMode = .scaleAspectFill
        ivContent.isUserInteractionEnabled = true
        ivContent.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
        }

        // Luot thich       Luot xem    Binh luan
        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackLike) -> (Void) in
            stackLike.snp.makeConstraints({ (maker) in
                maker.height.equalTo(28)
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
            (stackLike as! UIStackView).addArrangedSubview(UIView())
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
        
        //Thich            Binh luan
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
