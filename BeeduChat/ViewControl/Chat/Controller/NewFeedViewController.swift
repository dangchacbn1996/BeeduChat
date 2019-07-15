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
    
    var navigationView = UIView(background: Constant.color.naviBack, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: UIColor.gray, design: nil)
    var naviConstraint : NSLayoutConstraint!
    var naviLastOffset : CGFloat = 0
    var naviLastHeight : CGFloat = Constant.size.naviHeight
    var btnMenu = UIButton()
    var btnNoti = UIButton()
    var btnMore = UIButton()
    var lbClass = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    var lbSubClass = UILabel(text: "@fox.class", textColor: Constant.text.color.black, font: nil)
    
//    var newView = UIView(background: UIColor.white, corner: 0, border: 0, borderColor: nil, design: nil)
    var scrollMain = UIScrollView()
    var stackMain = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 0, design: nil)
    var stackNew = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)
    var avatar = ReuseForms.btnAvatar()
    var tfNew = UITextField(text: "", placeholder: "Viết gì đó cho cả lớp", textColor: Constant.text.color.black, font: nil)
//    var tvNew = UITextView()
    var btnLibrary = UIButton()
    
    var tableView = UITableView()
    var commentView = UIView()
    var avatarComent = ReuseForms.imageAvatar()
    var tfComment = UITextField(text: "", placeholder: "Viết bình luận", textColor: Constant.text.color.black, font: nil)
    
    
    var newFeedView = UIView(background: UIColor.white, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: nil, design: nil)
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
        
        self.view.addSubview(commentView)
        commentView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        commentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 16)
//            maker.top.equalTo(self.stackMain.snp.bottom)
            maker.width.centerX.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
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
        
        self.view.addSubview(scrollMain)
        scrollMain.delegate = self
        scrollMain.showsVerticalScrollIndicator = false
        scrollMain.bounces = false
//        scrollMain.bouncesZoom = false
        scrollMain.snp.makeConstraints { (maker) in
            maker.centerX.width.equalToSuperview()
            maker.bottom.equalTo(commentView.snp.top)
            maker.top.equalTo(self.view.subviews[self.view.subviews.firstIndex(of: self.scrollMain)! - 2].snp.bottom)
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
        self.stackMain.addArrangedSubview(UIView()) { (separate) -> (Void) in
            separate.backgroundColor = Constant.color.separate
            separate.snp.makeConstraints({ (maker) in
                maker.width.equalToSuperview()
                maker.height.equalTo(8)
            })
        }
        
        let content = NewsSubViewController()
        self.addChild(content)
        content.didMove(toParent: self)
        self.stackMain.addArrangedSubview(content.view)
    }
    
    func setupNewFeed(){
        
    }
}

extension NewFeedViewController : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        naviLastOffset = scrollView.contentOffset.y
        naviLastHeight = naviConstraint.constant
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let distance : CGFloat = naviLastOffset - scrollView.contentOffset.y
        
        var newHeight = naviLastHeight + distance
        print("Scroll----------------")
        print("ScrollHeight: \(naviConstraint.constant)")
        print("ScrollDistance  : \(distance)")
        print("ScrollNewHeight: \(newHeight)")
        if (newHeight > Constant.size.naviHeight){
            newHeight = Constant.size.naviHeight
        } else if (newHeight < 0){
            newHeight = 0
        } else {
//            scrollView.contentOffset.y = 0
        }
        naviConstraint.constant = newHeight
        var alpha = newHeight / Constant.size.naviHeight
        if (alpha < 0) {
            alpha = 0
        }
        if (alpha > 1) {
            alpha = 1
        }
        navigationView.alpha = alpha
//        let distance : CGFloat = naviLastOffset - scrollView.contentOffset.y
//        print("ScrollChange: \(distance)")
//        let newHeaderViewHeight: CGFloat = naviConstraint.constant + distance
//        naviLastOffset = scrollView.contentOffset.y
//        print("ScrollUpdate: \(naviLastOffset)")
//        if newHeaderViewHeight > Constant.size.naviHeight {
//            naviConstraint.constant = Constant.size.naviHeight
//        } else if newHeaderViewHeight < 0 {
//            naviConstraint.constant = 0
//        } else {
//            naviConstraint.constant = newHeaderViewHeight
//            scrollView.contentOffset.y = 0 // block scroll view
//        }
//
    }
}
