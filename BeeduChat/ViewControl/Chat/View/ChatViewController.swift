//
//  ChatViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {
    //khoi tao cac thanh phan giao dien
    var naviConstraint : NSLayoutConstraint!
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var stackViewTitle = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil)
    var btnMenu = UIButton()
    var lblClass = UILabel(text: "Lớp Bambi", textColor: Constant.text.color.black, font: nil)
    var lblSubClass = UILabel(text: "@bambi05", textColor: Constant.text.color.gray, font: nil)
    var btnContact = UIButton()
    var btnOption = UIButton()
    var searchView = UIView()
    var btnSearch = UIButton(background: .clear, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: .clear, design: nil)
    var txtSearch = UITextField(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var ceparateView = UIView()
    var historyView = UIView()
    var NortificationView = UIView()
    var lblNortification = UILabel()
    var tbvNortification = UITableView()
    var tbvCellNoritfication = UITableView()
    var chatView = UIView()
    var tbvChat = UITableView()
    var lblChat = UILabel(text: "Chat", textColor: UIColor.black, font: nil)
//    var clvHistory = UICollectionView(frame: .zero)
//    var scrvHistory = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tbvChat.delegate = self
        tbvChat.dataSource = self
//        tbvChat.register(ChatGeneralCell.self, forCellReuseIdentifier: ChatGeneralCell.identify)
        tbvChat.register(ChatGeneralCell.self, forCellReuseIdentifier: ChatGeneralCell.identify)
        tbvChat.tableFooterView = UIView()
        tbvChat.tableHeaderView = UIView()
        tbvChat.showsVerticalScrollIndicator = false
//        tbvChat.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tbvChat.separatorStyle = .singleLine
        // Do any additional setup after loading the view.
        tbvNortification.register(ChatGeneralCell.self, forCellReuseIdentifier: ChatGeneralCell.identify)
        tbvNortification.tableFooterView = UIView()
        tbvNortification.tableHeaderView = UIView()
        tbvNortification.separatorStyle = .singleLine
        tbvNortification.delegate = self
        tbvNortification.dataSource = self
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        edgeGes.edges = .left
        self.view.addGestureRecognizer(edgeGes)
    }
    
    @objc func goBack(){
        Constant.animationTo(view : self, type : .dismiss)
        self.dismiss(animated: false, completion: nil)
    }

}
extension ChatViewController{
    func setupUI() {
        UINavBar()
        addCeparate()
        UISearchBar()
        UIHisContactBar()
        UINortification()
        UIChat()
    }
    //NavBar
    func UINavBar(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(navigationView)
        //        navigationView.dropShadow(scale : true)
        //        navigationView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            //            maker.height.equalTo(Constant.size.naviHeight)
        }
        naviConstraint = navigationView.heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
        naviConstraint.isActive = true
        
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
                (stackClass as! UIStackView).addArrangedSubview(self.lblClass)
                (stackClass as! UIStackView).addArrangedSubview(self.lblSubClass)
            })
            
            //Btn noti
            (stackNavi as! UIStackView).addArrangedSubview(self.btnContact)
            self.btnContact.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.btnContact.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            self.btnContact.setImage(UIImage(named: "ic_contact")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnContact.tintColor = Constant.color.iconColor
            self.btnContact.contentMode = .scaleAspectFit
            
            //Btn more
            (stackNavi as! UIStackView).addArrangedSubview(self.btnOption)
            self.btnOption.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.btnOption.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.iconNormal)
            })
            self.btnOption.setImage(UIImage(named: "ic_more")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnOption.tintColor = Constant.color.iconColor
            self.btnOption.contentMode = .scaleAspectFit
        }
    }
    func addCeparate(){
        self.view.addSubview(ceparateView)
        ceparateView.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
            maker.width.equalToSuperview()
            maker.top.equalTo(navigationView.snp.bottom)
            maker.centerX.equalToSuperview()
        }
        ceparateView.backgroundColor = UIColorFromRGB(rgbValue: 0x363636)
    }
    //SearchBar
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigationView.snp.height).offset(-24)
            maker.width.equalTo(navigationView.snp.width).offset(-32)
            maker.top.equalTo(ceparateView.snp.bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp.centerX)
        }
        searchView.addSubview(UIView(background: UIColorFromRGB(rgbValue: 0xf3f3f3), corner: Constant.size.avatarNormal / 2, border: 0, borderColor: Constant.color.separate, design: nil)) { (srcView) -> (Void) in
            srcView.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
                maker.center.equalToSuperview()
            })
            //add button search
            srcView.addSubview(self.btnSearch)
            self.btnSearch.snp.makeConstraints({ (maker) in
//                maker.left.equalToSuperview()
                maker.width.equalTo(self.btnSearch.snp.height)
                maker.height.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.left.equalToSuperview().offset(8)
                
            })
//            self.btnSearch.backgroundColor = UIColor.red
            self.btnSearch.setImage(UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnSearch.tintColor = Constant.color.iconColor
            self.btnSearch.contentMode = .scaleToFill
            //add text field
            srcView.addSubview(self.txtSearch)
            self.txtSearch.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview().multipliedBy(0.7)
                maker.centerY.equalToSuperview()
                maker.left.equalTo(self.btnSearch.snp.right)
                maker.right.equalToSuperview().offset(-8)
            })
            self.txtSearch.placeholder = "Tìm kiếm"
        }
    }
    func UIHisContactBar(){
        self.view.addSubview(historyView)
        historyView.snp.makeConstraints { (maker) in
            maker.height.equalTo(searchView.snp.height)
            maker.width.equalTo(searchView.snp.width)
            maker.top.equalTo(searchView.snp.bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp.centerX)
        }
        historyView.backgroundColor = UIColor.green
//        historyView.addSubview(scrvHistory)
//        scrvHistory.snp.makeConstraints{ (maker) in
//            maker.height.equalTo(48)
//            maker.width.equalToSuperview()
//            maker.center.equalToSuperview()
//        }
//        scrvHistory.addSubview(clvHistory)
//        clvHistory.snp.makeConstraints { (maker) in
//            maker.height.width.centerX.centerY.equalToSuperview()
//        }
//        clvHistory.backgroundColor = UIColor.green
    }
    func UINortification(){
        self.view.addSubview(NortificationView)
        NortificationView.snp.makeConstraints { (maker) in
            maker.height.equalTo(80)
            maker.width.equalTo(navigationView.snp.width).offset(-32)
            maker.top.equalTo(historyView.snp.bottom).offset(16)
            maker.centerX.equalTo(historyView.snp.centerX)
        }
//        NortificationView.backgroundColor = UIColor.red
        NortificationView.addSubview(lblNortification)
        lblNortification.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblNortification.text = "Thông báo"
        lblNortification.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        NortificationView.addSubview(tbvNortification)
        tbvNortification.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblNortification.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalTo(80)
            maker.width.equalToSuperview()
        }
        
//        tbvNortification.backgroundColor = UIColor.green
        
    }
    func UIChat(){
        self.view.addSubview(chatView)
        chatView.snp.makeConstraints { (maker) in
            maker.width.equalTo(NortificationView.snp.width)
            maker.top.equalTo(NortificationView.snp.bottom).offset(40)
            maker.bottom.equalToSuperview()
            maker.centerX.equalTo(NortificationView.snp.centerX)
        }
//        chatView.backgroundColor = UIColor.red
        chatView.addSubview(lblChat)
        lblChat.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblChat.text = "Chat"
        lblChat.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        chatView.addSubview(tbvChat)
        tbvChat.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview()
            maker.width.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.top.equalTo(lblChat.snp.bottom)
        }
        
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

extension ChatViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.size.rowHeightChat
//        return UITableView.automaticDimension
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbvNortification {
            return 1
        }
        else {
            return 5
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbvNortification {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatGeneralCell.identify, for: indexPath) as! ChatGeneralCell
            cell.selectionStyle = .none
            if (indexPath.row % 2 == 0) {
                cell.data = ChatGeneralModel(avatar: UIImage(named: "ic_ava"), name: "Lớp  ", time: "12:30", content: "Thông báo", isRead: true)
            } else {
                cell.data = ChatGeneralModel(avatar: UIImage(named: "ic_ava"), name: "Lớp  ", time: "12:30", content: "Thông báo", isRead: true)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatGeneralCell.identify, for: indexPath) as! ChatGeneralCell
            cell.selectionStyle = .none
            if (indexPath.row % 2 == 0) {
                cell.data = ChatGeneralModel(avatar: UIImage(named: "ic_ava"), name: "User", time: "12:30", content: "Swinging in the backyard\nPull up in your fast car\nWhistling my name", isRead: true)
            } else {
                cell.data = ChatGeneralModel(avatar: UIImage(named: "ic_ava"), name: "User", time: "12:30", content: "Content", isRead: false)
            }
            return cell
        }
    }
    
}
