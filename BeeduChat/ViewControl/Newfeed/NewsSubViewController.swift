//
//  NewsSubViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class NewsSubViewController : UIViewController {
    
    var stackMain = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 0, design: nil)
    var stackNew = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 8, design: nil)
    var stackComment = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 8, design: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension NewsSubViewController {
    func setupUI() {
        self.view.addSubview(stackMain)
        stackMain.snp.makeConstraints { (maker) in
            maker.bottom.centerX.width.equalToSuperview()
            maker.top.equalToSuperview().offset(-16)
        }
        stackMain.addArrangedSubview(stackNew)
        setupNew()

        stackMain.addArrangedSubview(UIView()) { (separate) -> (Void) in
            separate.backgroundColor = Constant.color.separate
            separate.snp.makeConstraints({ (maker) in
                maker.height.equalTo(1)
            })
        }
        stackMain.addArrangedSubview(stackComment)
        setupComment()
    }
    
    func setupNew(){
        let stackHead = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
        self.stackNew.addArrangedSubview(stackHead)
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
                    maker.leading.top.trailing.equalToSuperview()
                    maker.height.equalTo(Constant.size.avatarNormal / 2)
                })
            })
            //1
            viewInfo.addSubview(UILabel(text: "Lớp Fox", textColor: Constant.text.color.gray, font: Constant.text.font.small), design: { (lbClass) -> (Void) in
                lbClass.snp.makeConstraints({ (maker) in
                    maker.leading.equalToSuperview()
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
                maker.width.equalTo(btnNote.snp.height)
                maker.width.equalTo(Constant.size.iconNormal)
            })
            btnNote.backgroundColor = UIColor.orange.withAlphaComponent(0.1)
        }
        
        stackHead.addArrangedSubview(UIButton()) { (btnMore) -> (Void) in
            btnMore.snp.makeConstraints({ (maker) in
                maker.width.equalTo(btnMore.snp.height)
                maker.width.equalTo(Constant.size.iconNormal)
            })
            btnMore.backgroundColor = UIColor.orange.withAlphaComponent(0.1)
        }
        
        self.stackNew.addArrangedSubview(stackHead)
        
        stackNew.addArrangedSubview(UILabel(text: "Năm 2015, ác quỷ Đầm Bích được đưa lên màn ảnh rộng qua bàn tay của bậc thầy kinh dị nước Nga ", textColor: Constant.text.color.black, font: nil)) { (lbPreview) -> (Void) in
            (lbPreview as! UILabel).numberOfLines = 0
        }
        
        stackNew.addArrangedSubview(UIImageView()) { (ivPreview) -> (Void) in
            ivPreview.snp.makeConstraints({ (maker) in
                maker.height.equalTo(ivPreview.snp.width).multipliedBy(0.75)
            })
            (ivPreview as! UIImageView).image = UIImage(named: "photo")
            ivPreview.contentMode = .scaleAspectFit
        }
        
        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackLike) -> (Void) in
            stackLike.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.text.font.normal.lineHeight ?? 16)
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
            })
            separate.backgroundColor = Constant.color.separate
        }
        
        stackNew.addArrangedSubview(UIStackView(axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 8, design: nil)) { (stackAction) -> (Void) in
            stackAction.snp.makeConstraints({ (maker) in
                maker.height.equalTo((Constant.text.font.normal.lineHeight ?? 16) * 1.5)
            })
            (stackAction as! UIStackView).addArrangedSubview(
                UILabel(text: "Thích", textColor: Constant.text.color.black, font: nil), design: { (lbLike) -> (Void) in
                    (lbLike as! UILabel).textAlignment = .center
            })
            (stackAction as! UIStackView).addArrangedSubview(
                UILabel(text: "Bình luận", textColor: Constant.text.color.black, font: nil), design: { (lbComment) -> (Void) in
                    (lbComment as! UILabel).textAlignment = .center
            })
        }
        
        self.stackNew.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.stackNew.isLayoutMarginsRelativeArrangement = true
    }
    
    func setupComment(){
        stackComment.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackComment.isLayoutMarginsRelativeArrangement = true
        stackComment.addArrangedSubview(UILabel(text: " Xem thêm bình luận khác", textColor: Constant.text.color.gray, font: nil), design: nil)
//        stackComment.snp.makeConstraints { (maker) in
//            maker.height.equalTo(550)
//        }
        
        let content = CommentSubViewController()
        self.addChild(content)
        content.didMove(toParent: self)
        stackComment.addArrangedSubview(content.view)
        content.view.snp.makeConstraints { (maker) in
            maker.height.equalTo(content.tableComment.contentSize.height)
        }
    }
}
