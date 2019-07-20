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
    var stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 0, design: nil)
//    var stackNew = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
    
    var tableView = UITableView()
    var commentView = UIView()
    var avatarComent = ReuseForms.imageAvatar()
    var tfComment = UITextField(text: "", placeholder: "Viết bình luận", textColor: Constant.text.color.black, font: nil)
    var navigationView : UIView!
    
    var newFeedView = UIView(background: UIColor.white, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: nil, design: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        edgeGes.edges = .left
        self.view.addGestureRecognizer(edgeGes)
    }
    
    @objc func goBack(){
        Constant.animationTo(view : self, type : .dismiss)
        self.dismiss(animated: false, completion: nil)
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
        
        navigationView = PostView.navigationView(lbTitle: lbClass, lbSubTitle: lbSubClass, btnMenu: btnMenu, btnFunction: btnNoti, btnMore: btnMore, actionMenu:
            UITapGestureRecognizer(target: self, action: #selector(goBack)), actionNotifi: nil, actionMore: nil)
        btnMenu.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.addSubview(scrollMain)
        self.view.addSubview(commentView)
        scrollMain.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(navigationView.snp.bottom)
            maker.bottom.equalTo(commentView.snp.top)
            maker.width.equalToSuperview()
        }
        commentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 16)
            maker.width.centerX.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        scrollMain.addSubview(stackMain)
        stackMain.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
            maker.width.equalToSuperview()
        }
        scrollMain.contentSize = stackMain.intrinsicContentSize
        commentView.backgroundColor = UIColor.white
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

        /* Separate
         **************************************
         */
        let contentView = PostView.postInfo()
        self.stackMain.addArrangedSubview(UIView()) { (view) -> (Void) in
            view.addSubview(contentView)
            contentView.snp.makeConstraints({ (maker) in
                maker.bottom.equalToSuperview()
                maker.leading.trailing.top.equalToSuperview()
            })
        }
        
        self.stackMain.addArrangedSubview(UIView()) { (separateView) -> (Void) in
            separateView.addSubview(UIView(), design: { (separate) -> (Void) in
                separate.backgroundColor = Constant.color.separate
                separate.snp.makeConstraints({ (maker) in
                    maker.width.centerX.equalToSuperview()
                    maker.top.equalToSuperview().offset(4)
                    maker.height.equalTo(Constant.size.separatorHeight)
                })
            })
        }
        
        let content = CommentViewController()
        self.addChild(content)
        content.didMove(toParent: self)
        self.stackMain.addArrangedSubview(content.view)
//        content.view.frame.size = content.tableComment.contentSize
    }
}
