//
//  NewFeedViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class PostInfoViewController: UIViewController {
    
//    var navigationView = UIView(background: Constant.color.naviBack, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: UIColor.gray, design: nil)
//    var naviConstraint : NSLayoutConstraint!
//    var naviLastOffset : CGFloat = 0
//    var naviLastHeight : CGFloat = Constant.size.naviHeight
    var btnMenu = UIButton()
    var btnNoti = UIButton()
    var btnMore = UIButton()
    var lbClass = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    var lbSubClass = UILabel(text: "@fox.class", textColor: Constant.text.color.black, font: nil)
    
    
//    var newView = UIView(background: UIColor.white, corner: 0, border: 0, borderColor: nil, design: nil)
    var scrollMain = UIScrollView()
    var stackMain = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 0, design: nil)
    var stackNew = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
//    var avatar = ReuseForms.btnAvatar()
//    var tfNew = UITextField(text: "", placeholder: "Viết gì đó cho cả lớp", textColor: Constant.text.color.black, font: nil)
////    var tvNew = UITextView()
//    var btnLibrary = UIButton()
    
    var tableView = UITableView()
    var commentView = UIView()
    var avatarComent = ReuseForms.imageAvatar()
    var tfComment = UITextField(text: "", placeholder: "Viết bình luận", textColor: Constant.text.color.black, font: nil)
    var navigationView : UIView!
    
    var newFeedView = UIView(background: UIColor.white, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: nil, design: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension PostInfoViewController{
    
    /************
    *   navi    *
    *-----------*
    * stackMain *
    ************/
    
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationView = PostView.navigationView(lbTitle: lbClass, lbSubTitle: lbSubClass, btnMenu: btnMenu, btnFunction: btnNoti, btnMore: btnMore, actionMenu: UITapGestureRecognizer(target: self, action: #selector(goBack)), actionNotifi: nil, actionMore: nil)
        btnMenu.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.addSubview(stackMain)
        self.view.addSubview(commentView)
        commentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 16)
            maker.width.centerX.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        stackMain.snp.makeConstraints { (maker) in
            maker.centerX.width.equalToSuperview()
            maker.bottom.equalTo(commentView.snp.top)
            maker.top.equalTo(self.navigationView.snp.bottom)
        }
        commentView.backgroundColor = UIColor.white
//        commentView.dropShadow()
        commentView.layer.shadowColor = UIColor.gray.cgColor
        commentView.layer.shadowOpacity = 0.5
        commentView.layer.shadowOffset = CGSize(width: 0, height: -1)
        commentView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackComment) -> (Void) in
            stackComment.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.height.equalToSuperview().offset(-16)
                maker.width.equalToSuperview().offset(-32)
            })
            (stackComment as! UIStackView).addArrangedSubview(self.avatarComent)
            
            (stackComment as! UIStackView).addArrangedSubview(
                UIView(background: UIColor.gray.withAlphaComponent(0.4), height: nil, ratioHW: nil, corner: Constant.size.avatarNormal / 2, border: 0, borderColor: nil, design: nil),
                design: { (container) -> (Void) in
                    container.addSubview(self.tfComment)
                    self.tfComment.snp.makeConstraints({ (maker) in
                        maker.center.equalToSuperview()
                        maker.size.equalToSuperview().offset(-16)
                    })
            })
        }
//        stackMain.addArrangedSubview(stackNew)
        
        /* New view
        *************************************
        * Avatar  Text                  pic *
        *************************************
        */
        stackMain.addArrangedSubview(PostView.newPost())
        /* Separate
         **************************************
         */
        self.stackMain.addArrangedSubview(UIView()) { (separate) -> (Void) in
            separate.backgroundColor = Constant.color.separate
            separate.snp.makeConstraints({ (maker) in
                maker.width.equalToSuperview()
                maker.height.equalTo(8)
            })
        }
        let contentView = PostView.postInfo()
        self.stackMain.addArrangedSubview(contentView)
        
        let content = CommentViewController()
        self.addChild(content)
        content.didMove(toParent: self)
        self.stackMain.addArrangedSubview(content.view)
    }
    
    func setupNewFeed(){
        
    }
}
