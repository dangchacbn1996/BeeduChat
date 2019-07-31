//
//  TNCreateNotificationViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/31/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNCreateNotificationViewController: TNBaseViewController {

    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var stackviewTitle = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil)
    var btnBack = UIButton()
    var lblClass = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    var lblSubClass = UILabel(text: "Cả lớp", textColor: Constant.text.color.gray, font: nil)
    var contentView = UIView()
    var tbvContent = UITableView()
    var ceparateView = UIView()
    var ceparateViewFooter = UIView()
    var stackViewAction = UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 4, design: nil)
    var txtcontent = UITextField(background: UIColor.white, corner: 0, border: 0, borderColor: nil, design: nil)
    var btnAddImg = UIButton()
    var btnAddAttach = UIButton()
    var btnSend = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        tbvContent.delegate = self
//        tbvContent.dataSource = self
//        tbvContent.register(TNCreateNotificationTableViewCell.self, forCellReuseIdentifier: TNCreateNotificationTableViewCell.identify)
        // Do any additional setup after loading the view.
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: setupUI(), action: #selector(goBack))
        edgeGes.edges = .left
        self.view.addGestureRecognizer(edgeGes)
    }
    @objc func goBack(){
        Constant.animationTo(view : self, type : .dismiss)
        self.dismiss(animated: false, completion: nil)
    }
}
extension TNCreateNotificationViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNCreateNotificationTableViewCell.identify, for: indexPath) as! TNCreateNotificationTableViewCell
        cell.selectionStyle = .none
        if (indexPath.row % 2 == 0) {
            cell.data = CreateNotifyModel(datetime: "Thứ 5, ngày 09/06/2019", title: "Lớp Fox: Thông báo", content: "Tuần sau học sinh thi học kỳ")
        }
        return cell
    }
}
extension TNCreateNotificationViewController{
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        UINavBar()
        addCeparate()
        UIContent()
        CeparateFooter()
        UIAction()
    }
    func UINavBar(){
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide)
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().offset(-32)
            maker.height.equalTo(Constant.size.naviHeight)
        }
        navigationView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.center.height.width.equalToSuperview()
        }
        stackView.addArrangedSubview(self.btnBack)
        btnBack.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.btnIcon)
            maker.width.equalTo(btnBack.snp.height)
        }
        self.btnBack.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnBack.contentMode = .scaleAspectFit
        self.btnBack.tintColor = Constant.color.iconColor
        self.btnBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goBack)))
        //add stackview Tittle lalbe
        stackView.addArrangedSubview(UIView())
        
        self.navigationView.addSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil),design: {(stackClass) -> (Void) in
            stackClass.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
            })
            self.lblClass.font = Constant.text.font.customFont(size: Constant.text.size.large, weight: .Bold)
            (stackClass as! UIStackView).addArrangedSubview(self.lblClass)
            (stackClass as! UIStackView).addArrangedSubview(self.lblSubClass)
        })
    }
    func addCeparate(){
        self.view.addSubview(ceparateView)
        ceparateView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.separatorHeight)
            maker.width.equalToSuperview()
            maker.top.equalTo(navigationView.snp.bottom)
            maker.centerX.equalToSuperview()
        }
        ceparateView.backgroundColor = Constant.color.separate
    }
    func UIContent(){
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
        maker.height.equalToSuperview().offset(-Constant.size.avatarNormal)
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(navigationView.snp.bottom).offset(4)
            maker.centerX.equalTo(navigationView.snp.centerX)
        }
        contentView.addSubview(tbvContent)
        tbvContent.snp.makeConstraints { (maker) in
            maker.height.width.centerX.equalToSuperview()
        }
    }
    func CeparateFooter(){
        self.view.addSubview(ceparateViewFooter)
        ceparateView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.separatorHeight)
            maker.width.equalToSuperview()
            maker.top.equalTo(contentView.snp.bottom)
            maker.centerX.equalToSuperview()
        }
        ceparateView.backgroundColor = Constant.color.separate
    }
    func UIAction(){
        self.view.addSubview(stackViewAction)
        stackViewAction.snp.makeConstraints { (maker) in
            maker.height.width.equalToSuperview()
            maker.left.equalTo(btnBack.snp.left)
            maker.right.equalToSuperview().offset((4))
        }
        stackViewAction.addArrangedSubview(txtcontent)
        txtcontent.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        txtcontent.placeholder = "Soạn thông báo"
        stackViewAction.addArrangedSubview(btnAddImg)
        btnAddImg.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.btnIcon)
            maker.width.equalTo(btnAddImg.snp.height)
        }
        btnAddImg.setImage(UIImage(named: "ic_photo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        stackViewAction.addArrangedSubview(btnAddAttach)
        btnAddAttach.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.btnIcon)
            maker.width.equalTo(btnAddAttach.snp.height)
        }
        btnAddAttach.setImage(UIImage(named: "Post Attach")?.withRenderingMode(.alwaysTemplate), for: .normal)
        stackViewAction.addArrangedSubview(btnSend)
        btnSend.backgroundColor = Constant.color.btnContinue
        btnSend.setTitle("Gửi", for: .normal)
        
    }
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
