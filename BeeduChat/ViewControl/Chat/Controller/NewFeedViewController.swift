//
//  NewFeedViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class NewFeedViewController: UIViewController {
    
    var navigationView = UIView(background: Constant.color.naviBack, corner: 0, border: 0, borderColor: UIColor.gray, design: nil)
    var btnMenu = UIButton()
    var btnNoti = UIButton()
    var btnMore = UIButton()
    var lbClass = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    var lbSubClass = UILabel(text: "@fox.class", textColor: Constant.text.color.black, font: nil)
    
//    var newView = UIView(background: UIColor.white, corner: 0, border: 0, borderColor: nil, design: nil)
    var scrollMain = UIScrollView()
    var stackMain = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 0, design: nil)
    var stackNew = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
    var avatar = UIButton(background: .clear, corner: Constant.size.avatarNormal / 2, border: 0, borderColor: nil, design: nil)
    var tfNew = UITextField(text: "", placeholder: "Viết gì đó cho cả lớp", textColor: Constant.text.color.black, font: nil)
//    var tvNew = UITextView()
    var btnLibrary = UIButton()
    
    var tableView = UITableView()
    var commentView = UIView()
    var avatarComent = UIImageView(background: .clear, corner: Constant.size.avatarNormal / 2, border: 0, borderColor: nil, design: nil)
    var tfComment = UITextField(text: "", placeholder: "Viết bình luận", textColor: Constant.text.color.black, font: nil)
    
    
    var newFeedView = UIView(background: UIColor.white, corner: 0, border: 0, borderColor: nil, design: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension NewFeedViewController{
    
    /************
    *   navi    *
    *-----------*
    * stackMain *
    ************/
    
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(navigationView)
//        navigationView.dropShadow(scale : true)
        //        navigationView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            maker.height.equalTo(Constant.size.naviHeight)
        }
        
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
            (stackNavi as! UIStackView).addArrangedSubview(self.btnMenu)
            self.btnMenu.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.btnMenu.snp.height)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            self.btnMenu.setImage(UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnMenu.tintColor = Constant.color.iconColor
            self.btnMenu.contentMode = .scaleAspectFit
//            self.btnMenu.backgroundColor = UIColor.blue
            
            //Ten lop
            (stackNavi as! UIStackView).addArrangedSubview(UIView())
            
            self.navigationView.addSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil), design: { (stackClass) -> (Void) in
                stackClass.snp.makeConstraints({ (maker) in
                    maker.center.equalToSuperview()
//                    maker.height.equalToSuperview()
                    
                })
                (stackClass as! UIStackView).addArrangedSubview(self.lbClass)
                (stackClass as! UIStackView).addArrangedSubview(self.lbSubClass)
            })
            
            //Btn noti
            (stackNavi as! UIStackView).addArrangedSubview(self.btnNoti)
            self.btnNoti.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.btnNoti.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            self.btnNoti.setImage(UIImage(named: "ic_noti")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnNoti.tintColor = Constant.color.iconColor
            self.btnNoti.contentMode = .scaleAspectFit
            
            //Btn more
            (stackNavi as! UIStackView).addArrangedSubview(self.btnMore)
            self.btnMore.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.btnMore.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            self.btnMore.setImage(UIImage(named: "ic_more")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnMore.tintColor = Constant.color.iconColor
            self.btnMore.contentMode = .scaleAspectFit
        }
        
        /* Separate
         **************************************
         */
        self.view.addSubview(UIView()) { (separate) -> (Void) in
            separate.snp.makeConstraints({ (maker) in
                maker.centerX.width.equalToSuperview()
                maker.top.equalTo(self.navigationView.snp.bottom).offset(1)
                maker.height.equalTo(1)
            })
            separate.backgroundColor = Constant.color.separate
        }
        
        
        self.view.addSubview(scrollMain)
        

        scrollMain.snp.makeConstraints { (maker) in
            maker.centerX.width.bottom.equalTo(self.view.safeAreaLayoutGuide)
            maker.top.equalTo(self.view.subviews[self.view.subviews.firstIndex(of: self.scrollMain)! - 1].snp.top)
        }
        
        self.scrollMain.addSubview(stackMain)
        stackMain.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.bottom.equalToSuperview()
            maker.width.equalToSuperview()
        }
        stackMain.addArrangedSubview(stackNew)
        
        /* New view
        *************************************
        * Avatar  Text                  pic *
        *************************************
        */
        stackNew.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 32)
        }
        stackNew.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackNew.isLayoutMarginsRelativeArrangement = true
        stackNew.addArrangedSubview(UIView()) { (viewAvatar) -> (Void) in
            viewAvatar.snp.makeConstraints({ (maker) in
                maker.width.equalTo(Constant.size.avatarNormal)
                maker.height.equalToSuperview().offset(-32)
            })
            viewAvatar.addSubview(self.avatar)
            self.avatar.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.equalToSuperview()
                maker.height.equalTo(self.avatar.snp.width)
            })
            self.avatar.contentMode = .scaleAspectFit
            self.avatar.setImage(UIImage(named: "ic_ava"), for: .normal)
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
                maker.width.equalTo(self.stackNew.subviews[0].snp.width).multipliedBy(0.7)
                maker.height.equalToSuperview().offset(-32)
            })
            viewLib.addSubview(self.btnLibrary)
            self.btnLibrary.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.equalToSuperview()
                maker.height.equalTo(Constant.size.iconNormal)
            })
            self.btnLibrary.contentMode = .scaleAspectFit
            self.btnLibrary.setImage(UIImage(named: "ic_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnLibrary.tintColor = Constant.color.iconColor
        }
        
        /* Separate
         **************************************
         */
        self.view.addSubview(UIView()) { (separate) -> (Void) in
            separate.snp.makeConstraints({ (maker) in
                maker.centerX.width.equalToSuperview()
                maker.top.equalTo(self.stackNew.snp.bottom).offset(1)
                maker.height.equalTo(1)
            })
            separate.backgroundColor = Constant.color.separate
        }
        
        let content = NewsSubViewController()
        self.addChild(content)
        content.didMove(toParent: self)
        self.stackMain.addArrangedSubview(content.view)
        
        stackMain.addArrangedSubview(commentView)
        commentView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        commentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 16)
        }
        commentView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackComment) -> (Void) in
            stackComment.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.height.equalToSuperview().offset(-16)
                maker.width.equalToSuperview().offset(-32)
            })
            (stackComment as! UIStackView).addArrangedSubview(self.avatarComent)
            self.avatarComent.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.avatarComent.snp.height)
            })
            self.avatarComent.image = UIImage(named: "ic_ava")
            (stackComment as! UIStackView).addArrangedSubview(
                UIView(background: UIColor.gray.withAlphaComponent(0.4), corner: Constant.size.avatarNormal / 2, border: 0, borderColor: nil, design: nil),
                design: { (container) -> (Void) in
                    container.addSubview(self.tfComment)
                    self.tfComment.snp.makeConstraints({ (maker) in
                        maker.center.equalToSuperview()
                        maker.size.equalToSuperview().offset(-16)
                    })
            })
        }
    }
}
