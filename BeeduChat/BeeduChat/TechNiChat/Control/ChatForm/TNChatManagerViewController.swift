//
//  ChatViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNChatManagerViewController: TNBaseViewController {
    //khoi tao cac thanh phan giao dien
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
    var historyView = UIView()
    var NortificationView = UIView()
    var lblNortification = UILabel()
    var tbvNortification = UITableView()
    var tbvCellNoritfication = UITableView()
    var chatView = UIView()
    var tbvChat = UITableView()
    var lblChat = UILabel(text: "Chat", textColor: UIColor.black, font: nil)
    var btnCreateChat : UIButton!
    var ceparateView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tbvChat.delegate = self
        tbvChat.dataSource = self
        tbvChat.register(TNChatGeneralCell.self, forCellReuseIdentifier: TNChatGeneralCell.identify)
        tbvChat.tableFooterView = UIView()
        tbvChat.showsVerticalScrollIndicator = false
        
        tbvNortification.register(TNChatGeneralCell.self, forCellReuseIdentifier: TNChatGeneralCell.identify)
        tbvNortification.tableFooterView = UIView()
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
    
    @objc func goContact(){
        let viewContact = TNContactViewController()
        viewContact.modalPresentationStyle = .overFullScreen
        self.view.window!.layer.add(Constant.rightToLeftTrans(), forKey: kCATransition)
        self.present(viewContact, animated: false, completion: nil)
        
    }
    
    @objc func actGoCreateNew(){
        let vc = TNChooseRecvViewController()
        self.present(vc, animated: true, completion: nil)
    }

}

extension TNChatManagerViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbvNortification {
            return 1
        }
        else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == tbvChat) {
            let vc = BasicExampleViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbvNortification {
            let cell = tableView.dequeueReusableCell(withIdentifier: TNChatGeneralCell.identify, for: indexPath) as! TNChatGeneralCell
            cell.selectionStyle = .none
            if (indexPath.row % 2 == 0) {
                cell.data = ChatGeneralModel(avatar: UIImage(named: "ic_ava"), name: "Lớp  ", time: "12:30", content: "Thông báo", isRead: true)
            } else {
                cell.data = ChatGeneralModel(avatar: UIImage(named: "ic_ava"), name: "Lớp  ", time: "12:30", content: "Thông báo", isRead: true)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TNChatGeneralCell.identify, for: indexPath) as! TNChatGeneralCell
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

extension TNChatManagerViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: TNUserChatCVC.identify, for: indexPath) as! TNUserChatCVC
        item.backgroundColor = UIColor.white
        return item
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.size.rowHeightChat
    }
}

/*  SetupUI */
extension TNChatManagerViewController{
    func setupUI() {
        UINavBar()
        addCeparate()
        UISearchBar()
        UIHisContactBar()
        UINortification()
        UIChat()
        uiCreateChat()
    }
    
    //NavBar
    func UINavBar(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        naviBtnRight = UIButton(frame: .zero)
        naviBtnRight!.setImage(UIImage(named: "ic_contact")?.withRenderingMode(.alwaysTemplate), for: .normal)
        naviBtnRight?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goContact)))
        naviLbTitle = UILabel(text: "Tin nhắn",
                              textColor: Constant.text.color.black,
                              font: Constant.text.font.customFont(
                                size: Constant.text.size.large,
                                weight: .Bold
        ))
        setNavigation(image: UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate), leftAction: UITapGestureRecognizer(target: self, action: #selector(goBack)))
    }
    func addCeparate(){
        self.view.addSubview(ceparateView)
        ceparateView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.separatorHeight)
            maker.width.equalToSuperview()
            maker.top.equalTo(navigation.snp.bottom)
            maker.centerX.equalToSuperview()
        }
        ceparateView.backgroundColor = Constant.color.separate
    }
    //SearchBar
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigation.snp.height).offset(-24)
            maker.width.equalTo(navigation.snp.width).offset(-32)
            maker.top.equalTo(navigation.snp.bottom).offset(16)
            maker.centerX.equalTo(navigation.snp.centerX)
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
                maker.width.equalTo(self.btnSearch.snp.height)
                maker.height.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.left.equalToSuperview().offset(8)
                
            })
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
            maker.height.equalTo(TNUserChatCVC.cellSize.height)
            maker.width.equalTo(searchView.snp.width)
            maker.top.equalTo(searchView.snp.bottom).offset(16)
            maker.centerX.equalTo(navigation.snp.centerX)
        }
        historyView.addSubview(UIScrollView(frame: .zero)) { (scrollView) -> (Void) in
            scrollView.snp.makeConstraints({ (maker) in
                maker.top.leading.trailing.bottom.equalToSuperview()
                maker.height.width.equalToSuperview()
            })
            scrollView.addSubview(UICollectionView(frame: .zero, collectionViewLayout: TNCustomCollectionLayout()), design: { (collection) -> (Void) in
                collection.snp.makeConstraints({ (maker) in
                    maker.top.leading.trailing.bottom.equalToSuperview()
                    maker.height.equalToSuperview()
                    maker.width.equalTo(30 * TNUserChatCVC.cellSize.width)
                })
                (collection as! UICollectionView).delegate = self
                (collection as! UICollectionView).dataSource = self
                (collection as! UICollectionView).collectionViewLayout = UICollectionViewFlowLayout()
                (collection as! UICollectionView).register(TNUserChatCVC.self, forCellWithReuseIdentifier: TNUserChatCVC.identify)
            })
        }
    }
    
    func UINortification(){
        self.view.addSubview(NortificationView)
        NortificationView.snp.makeConstraints { (maker) in
            maker.height.equalTo(80)
            maker.width.equalTo(navigation.snp.width).offset(-32)
            maker.top.equalTo(historyView.snp.bottom).offset(16)
            maker.centerX.equalTo(historyView.snp.centerX)
        }
        NortificationView.addSubview(lblNortification)
        lblNortification.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblNortification.text = "Thông báo"
        lblNortification.font = Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Bold)
        NortificationView.addSubview(tbvNortification)
        tbvNortification.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblNortification.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalTo(80)
            maker.width.equalToSuperview()
        }
    }
    
    func UIChat(){
        self.view.addSubview(chatView)
        chatView.snp.makeConstraints { (maker) in
            maker.width.equalTo(NortificationView.snp.width)
            maker.top.equalTo(NortificationView.snp.bottom).offset(40)
            maker.bottom.equalToSuperview()
            maker.centerX.equalTo(NortificationView.snp.centerX)
        }
        chatView.addSubview(lblChat)
        lblChat.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblChat.text = "Chat"
        lblChat.font = Constant.text.font.customFont(size: Constant.text.size.large, weight: .Bold)
        chatView.addSubview(tbvChat)
        tbvChat.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview()
            maker.width.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.top.equalTo(lblChat.snp.bottom)
        }
        
    }
    
    func uiCreateChat(){
        btnCreateChat = UIButton(frame: .zero)
        self.view.addSubview(btnCreateChat)
        btnCreateChat.snp.makeConstraints { (maker) in
            maker.right.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
            maker.height.width.equalTo(56)
        }
        btnCreateChat.setImage(UIImage(named: "ic_floating"), for: .normal)
//        btnCreateChat.tintColor = .white
        btnCreateChat.imageView?.contentMode = .scaleAspectFit
        btnCreateChat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actGoCreateNew)))
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
