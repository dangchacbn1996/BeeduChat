//
//  TNMessageViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 8/1/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNMessageViewController: TNBaseViewController {
    var naviConstraint : NSLayoutConstraint!
    var ceparateView = UIView()
    var contactView = UIView()
    var scrollView = UIScrollView(frame: .zero)
    var userView = UIView(background: Constant.color.separate, corner: Constant.size.avatarSmall, border: 0, borderColor: Constant.color.separate, design: nil)
    var lblUser = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    var lblSend = UILabel(text: "Gửi: ", textColor: Constant.text.color.black, font: Constant.text.font.customFont(
        size: Constant.text.size.large,
        weight: .Semi_Bold))
    var btnAdd = UIButton()
    var ContentView = UIView(background: UIColor.white, corner: 0, border: 1, borderColor: Constant.color.separate, design: nil)
    var txtMess = UITextField()
    var btnAttach = UIButton()
    var btnCalender = UIButton()
    var btnSend = UIButton(background: Constant.color.btnContinue, corner: 18, border: 0, borderColor: Constant.color.separate, design: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        edgeGes.edges = .left
        self.view.addGestureRecognizer(edgeGes)
    }
    @objc func goBack(){
        Constant.animationTo(view : self, type : .dismiss)
        self.dismiss(animated: false, completion: nil)
    }
}
extension TNMessageViewController{
    func setupUI(){
        UINavBar()
        UIContactBar()
        UIContent()
    }
    func UINavBar(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        naviLbTitle = UILabel(text: "Soạn tin nhắn",
                              textColor: Constant.text.color.black,
                              font: Constant.text.font.customFont(
                                size: Constant.text.size.large,
                                weight: .Semi_Bold))
        setNavigation(image: UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), leftAction: UITapGestureRecognizer(target: self, action: #selector(goBack)))
        naviSeparate.alpha = 1
    }
    func UIContactBar(){
        self.view.addSubview(contactView)
        contactView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigation.snp.height).offset(-24)
            maker.width.equalTo(navigation.snp.width).offset(-2 * Constant.size.paddingView)
            maker.top.equalTo(navigation.snp.bottom).offset(16)
            maker.centerX.equalTo(navigation.snp.centerX)
            maker.right.equalToSuperview()
        }
        contactView.addSubview(lblSend)
        lblSend.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview().offset(12)
        }
        contactView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.left.equalTo(lblSend.snp.right).offset(4)
            maker.width.equalToSuperview().offset(-Constant.size.btnIcon)
        }
        scrollView.addSubview(userView)
        userView.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.width.equalTo(100)
        }
        userView.addSubview(lblUser)
        lblUser.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        contactView.addSubview(btnAdd)
        btnAdd.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.btnIcon)
            maker.width.equalTo(btnAdd.snp.height)
            maker.right.equalToSuperview().offset(-12)
            maker.centerY.equalTo(lblSend.snp.centerY)
        }
        btnAdd.setImage(UIImage(named: "Add HS")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnAdd.tintColor = Constant.color.iconColor
    }
    func UIContent(){
        self.view.addSubview(ContentView)
        ContentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(220)
            maker.width.equalTo(contactView.snp.width).offset(-24)
            maker.top.equalTo(contactView.snp.bottom).offset(12)
            maker.left.equalTo(lblSend.snp.left)
            maker.right.equalTo(btnAdd.snp.right)
        }
        ContentView.addSubview(btnAttach)
        btnAttach.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarSmall)
            maker.width.equalTo(btnAttach.snp.height)
            maker.left.equalToSuperview().offset(12)
            maker.bottom.equalToSuperview().offset(-12)
        }
        btnAttach.setImage(UIImage(named: "Post Attach")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnAttach.tintColor = Constant.color.iconColor
        ContentView.addSubview(btnCalender)
        btnCalender.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarSmall)
            maker.width.equalTo(btnCalender.snp.height)
            maker.left.equalTo(btnAttach.snp.right).offset(8)
            maker.bottom.equalToSuperview().offset(-12)
        }
        btnCalender.setImage(UIImage(named: "calendar")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnCalender.tintColor = Constant.color.iconColor
        ContentView.addSubview(btnSend)
        btnSend.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal)
            maker.width.equalTo(80)
            maker.right.equalToSuperview().offset(-12)
            maker.bottom.equalToSuperview().offset(-12)
        }
        btnSend.setTitle("Gửi", for: .normal)
        btnSend.clipsToBounds = true
        ContentView.addSubview(txtMess)
        txtMess.snp.makeConstraints { (maker) in
            maker.left.equalTo(btnAttach.snp.left)
            maker.top.equalToSuperview().offset(8)
            maker.right.equalTo(btnSend.snp.right)
            maker.width.equalToSuperview()
//            maker.height.equalToSuperview()
        }
        txtMess.placeholder = "Tuần sau thi học kỳ"
    }
}
