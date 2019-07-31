//
//  ChooseRecvViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/10/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNChooseRecvViewController: UIViewController {
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var lblTitle = UILabel()
    var btnBack = UIButton()
    var searchView = UIView()
    var btnSearch = UIButton()
    var txtSearch = UITextField()
    var SendAllView = UIView()
    var lblSendAll = UILabel()
    var tbvSendAll = UITableView()
    var tbvCellSendAll = UITableView()
    var sendGroupView = UIView()
    var lblSendGroup = UILabel()
    var tbvSendGroup = UITableView()
    var tbvCellSendGroup = UITableViewCell()
    var lblAdd = UILabel()
    var sendPrivateView = UIView()
    var lblSendPrivate = UILabel()
    var tbvSendPrivate = UITableView()
    var tbvCellSendPrivate = UITableViewCell()
    var btnContinue = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
        tbvSendAll.register(TNChooseRecvCell.self, forCellReuseIdentifier: TNChooseRecvCell.identify)
        tbvSendAll.tableFooterView = UIView()
        tbvSendAll.tableHeaderView = UIView()
        tbvSendAll.separatorStyle = .singleLine
        tbvSendAll.delegate = self
        tbvSendAll.dataSource = self
        
        tbvSendGroup.register(TNChooseRecvCell.self, forCellReuseIdentifier: TNChooseRecvCell.identify)
        tbvSendGroup.tableHeaderView = UIView()
        tbvSendGroup.tableFooterView = UIView()
        tbvSendGroup.separatorStyle = .singleLine
        tbvSendGroup.delegate = self
        tbvSendGroup.dataSource = self
        
        tbvSendPrivate.register(TNChooseRecvCell.self, forCellReuseIdentifier: TNChooseRecvCell.identify)
        tbvSendPrivate.tableHeaderView = UIView()
        tbvSendPrivate.tableFooterView = UIView()
        tbvSendPrivate.separatorStyle = .singleLine
        tbvSendPrivate.delegate = self
        tbvSendPrivate.dataSource = self
    }
    
    @objc func actGoBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goAddNotify(){
        let viewNotify = TNCreateNotificationViewController()
        viewNotify.modalPresentationStyle = .overFullScreen
        self.view.window?.layer.add(Constant.rightToLeftTrans(),forKey: kCATransition)
        self.present(viewNotify,animated: false,completion: nil)
    }
    
    @objc func addFunction(){
//        let view = TNActionSheetViewController()
//        view.modalPresentationStyle = .overCurrentContext
//        view.data = [TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
//                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
//                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
//                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1")]
//        self.present(view, animated: false, completion: nil)
    }
}
extension TNChooseRecvViewController{
    func setupUI(){
        UINavBar()
        UISearchBar()
        UIButtonContinue()
        UIScrollContent()
//        UISendAll()
//        UISendGroup()
//        UISendPrivate()
    }
    func UINavBar(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide)
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().offset(-32)
            maker.height.equalTo(40)
        }
        navigationView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.center.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
        stackView.addArrangedSubview(self.lblTitle)
        lblTitle.snp.makeConstraints { (maker) in
            maker.left.top.bottom.equalToSuperview()
        }
        lblTitle.text = "Chọn người nhận"
        lblTitle.textColor = Constant.text.color.black
        lblTitle.font = Constant.text.font.customFont(size: 24, weight: Constant.text.font.weight.Semi_Bold)
        
        stackView.addArrangedSubview(self.btnBack)
        btnBack.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-Constant.size.paddingView)
            maker.centerY.equalToSuperview()
            maker.height.width.equalTo(Constant.size.btnIcon)
        }
        self.btnBack.setImage(UIImage(named: "ic_delete")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnBack.contentMode = .scaleAspectFit
        self.btnBack.tintColor = Constant.color.iconColor
        self.btnBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actGoBack)))
    }
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigationView.snp.height)
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(navigationView.snp.bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp.centerX)
        }
        searchView.addSubview(UIView(background: UIColorFromRGB(rgbValue: 0xf3f3f3), corner: Constant.size.avatarSmall, border: 0, borderColor: UIColor.gray, design: nil)) { (srcView) -> (Void) in
            srcView.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
                maker.center.equalToSuperview()
            })
            //add button search
            srcView.addSubview(self.btnSearch)
            self.btnSearch.snp.makeConstraints({ (maker) in
                //                maker.left.equalToSuperview()
                maker.height.equalTo(self.btnSearch.snp.width)
                maker.height.equalTo(Constant.size.btnIcon)
                maker.centerY.equalToSuperview()
                maker.left.equalToSuperview().offset(16)
                
            })
//            self.btnSearch.backgroundColor = UIColor.red
            self.btnSearch.setImage(UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnSearch.tintColor = Constant.color.iconColor
            self.btnSearch.imageView?.contentMode = .scaleAspectFit
            //add text field
            srcView.addSubview(self.txtSearch)
            self.txtSearch.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview().multipliedBy(0.7)
                maker.centerY.equalToSuperview()
                maker.left.equalTo(self.btnSearch.snp.right).offset(8)
                maker.right.equalToSuperview().offset(-8)
            })
            self.txtSearch.placeholder = "Nhập tên, số điện thoại, email"
        }
    }
    func UIScrollContent(){
        self.view.addSubview(UIScrollView(frame: .zero)){
            (scrollView) -> (Void) in
            scrollView.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.navigationView.snp.width)
                maker.top.equalTo(self.searchView.snp.bottom).offset(16)
                maker.centerX.equalTo(self.searchView.snp.centerX)
//                maker.height.equalToSuperview()
                maker.bottom.equalTo(self.btnContinue.snp.top)
            })
            let stackviewScrol = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center, spacing: 8, design: nil)
            scrollView.addSubview(stackviewScrol)
            stackviewScrol.snp.makeConstraints({ (maker) in
                maker.width.equalToSuperview()
//                maker.height.equalToSuperview()
//                maker.centerX.equalToSuperview()
                maker.top.leading.trailing.bottom.equalToSuperview()
            })
//            stackviewScrol.snp.mak
            //view gui ca lop
            stackviewScrol.addArrangedSubview(self.SendAllView)
            self.SendAllView.snp.makeConstraints { (maker) in
                maker.height.equalTo(160)
                maker.width.equalTo(self.navigationView.snp.width)
//                maker.top.equalTo(self.searchView.snp.bottom).offset(16)
                maker.centerX.equalTo(self.searchView.snp.centerX)
            }
            //        SendAllView.backgroundColor = UIColor.red
            self.SendAllView.addSubview(self.lblSendAll)
            self.lblSendAll.snp.makeConstraints { (maker) in
                maker.top.left.equalToSuperview()
            }
            self.lblSendAll.text = "Gửi cả lớp"
            self.lblSendAll.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            self.SendAllView.addSubview(self.tbvSendAll)
            self.tbvSendAll.snp.makeConstraints { (maker) in
                maker.top.equalTo(self.lblSendAll.snp.bottom).offset(8)
                maker.left.equalToSuperview()
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
            }
            //view gui cho nhom
            stackviewScrol.addArrangedSubview(self.sendGroupView)
            self.sendGroupView.snp.makeConstraints { (maker) in
                maker.height.equalTo(160)
                maker.width.equalTo(self.navigationView.snp.width)
                maker.top.equalTo(self.SendAllView.snp.bottom).offset(32)
                maker.centerX.equalTo(self.SendAllView.snp.centerX)
            }
            //        sendGroupView.backgroundColor = UIColor.red
            self.sendGroupView.addSubview(self.lblSendGroup)
            self.lblSendGroup.snp.makeConstraints { (maker) in
                maker.top.left.equalToSuperview()
            }
            self.lblSendGroup.text = "Gửi cho nhóm"
            self.lblSendGroup.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            
            self.sendGroupView.addSubview(self.lblAdd)
            self.lblAdd.snp.makeConstraints { (maker) in
                maker.top.right.equalToSuperview()
            }
            self.lblAdd.textColor = self.UIColorFromRGB(rgbValue: 0x4a658d)
            self.lblAdd.text = "Thêm"
            self.lblAdd.isUserInteractionEnabled = true
            self.lblAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addFunction)))
            self.sendGroupView.addSubview(self.tbvSendGroup)
            self.tbvSendGroup.snp.makeConstraints { (maker) in
                maker.top.equalTo(self.lblSendGroup.snp.bottom).offset(8)
                maker.left.equalToSuperview()
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
            }
            //gui ca nhan
            stackviewScrol.addArrangedSubview(self.sendPrivateView)
            self.sendPrivateView.snp.makeConstraints { (maker) in
                maker.height.equalTo(400)
                maker.width.equalTo(self.navigationView.snp.width)
                maker.top.equalTo(self.sendGroupView.snp.bottom).offset(32)
//                maker.centerX.equalTo(self.sendGroupView.snp.centerX)
            }
            //        sendPrivateView.backgroundColor = UIColor.red
            self.sendPrivateView.addSubview(self.lblSendPrivate)
            self.lblSendPrivate.snp.makeConstraints { (maker) in
                maker.top.left.equalToSuperview()
            }
            self.lblSendPrivate.text = "Gửi cá nhân"
            self.lblSendPrivate.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            self.sendPrivateView.addSubview(self.tbvSendPrivate)
            self.tbvSendPrivate.snp.makeConstraints { (maker) in
                maker.top.equalTo(self.lblSendPrivate.snp.bottom).offset(8)
                maker.left.equalToSuperview()
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
            }
            
        }
    }
    func UISendAll(){
//        self.view.addSubview(SendAllView)
        SendAllView.snp.makeConstraints { (maker) in
            maker.height.equalTo(160)
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(searchView.snp.bottom).offset(16)
            maker.centerX.equalTo(searchView.snp.centerX)
        }
//        SendAllView.backgroundColor = UIColor.red
        SendAllView.addSubview(lblSendAll)
        lblSendAll.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblSendAll.text = "Gửi cả lớp"
        lblSendAll.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        SendAllView.addSubview(tbvSendAll)
        tbvSendAll.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblSendAll.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
        
//        tbvSendAll.backgroundColor = UIColor.green
        
    }
    func UISendGroup(){
//        self.view.addSubview(sendGroupView)
        sendGroupView.snp.makeConstraints { (maker) in
            maker.height.equalTo(160)
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(SendAllView.snp.bottom).offset(32)
            maker.centerX.equalTo(SendAllView.snp.centerX)
        }
//        sendGroupView.backgroundColor = UIColor.red
        sendGroupView.addSubview(lblSendGroup)
        lblSendGroup.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblSendGroup.text = "Gửi cho nhóm"
        lblSendGroup.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        
        sendGroupView.addSubview(lblAdd)
        lblAdd.snp.makeConstraints { (maker) in
            maker.top.right.equalToSuperview()
        }
        lblAdd.textColor = UIColorFromRGB(rgbValue: 0x4a658d)
        lblAdd.text = "Thêm"
        lblAdd.isUserInteractionEnabled = true
        lblAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addFunction)))
        sendGroupView.addSubview(tbvSendGroup)
        tbvSendGroup.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblSendGroup.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
        
//        tbvSendGroup.backgroundColor = UIColor.green
        
    }
    func UISendPrivate(){
//        self.view.addSubview(sendPrivateView)
        sendPrivateView.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(sendGroupView.snp.bottom).offset(32)
            maker.centerX.equalTo(sendGroupView.snp.centerX)
        }
//        sendPrivateView.backgroundColor = UIColor.red
        sendPrivateView.addSubview(lblSendPrivate)
        lblSendPrivate.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblSendPrivate.text = "Gửi cá nhân"
        lblSendPrivate.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        sendPrivateView.addSubview(tbvSendPrivate)
        tbvSendPrivate.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblSendPrivate.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
        
//        tbvSendPrivate.backgroundColor = UIColor.green
        
    }
    func UIButtonContinue(){
        self.view.addSubview(btnContinue)
        btnContinue.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview()
            maker.height.equalTo(Constant.size.avatarBig)
            maker.width.equalToSuperview()
        }
        btnContinue.backgroundColor = Constant.color.btnContinue
        btnContinue.setTitle("Tiếp tục", for: .normal)
//        btnContinue.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goAddNotify)))
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
extension TNChooseRecvViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.size.rowHeightChat
    }
}
extension TNChooseRecvViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbvSendAll || tableView == tbvSendGroup
            {return 2}
        else{
        return 5}
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbvSendAll {
            let cell = tableView.dequeueReusableCell(withIdentifier: TNChooseRecvCell.identify, for: indexPath) as! TNChooseRecvCell
            cell.selectionStyle = .none
            if (indexPath.row % 2 == 0)
            {
                cell.data = TNChooseRecvCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Thế Tân", content: "Phụ huynh")
            }else{
                cell.data = TNChooseRecvCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Thế Tân", content: "Phụ huynh")
            }
            return cell
        }
        else if tableView == tbvSendGroup {
            let cell = tableView.dequeueReusableCell(withIdentifier: TNChooseRecvCell.identify, for: indexPath) as! TNChooseRecvCell
            cell.selectionStyle = .none
            if (indexPath.row % 2 == 0)
            {
                cell.data = TNChooseRecvCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Thế Tân", content: "Phụ huynh")
            }else{
                cell.data = TNChooseRecvCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Thế Tân", content: "Phụ huynh")
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TNChooseRecvCell.identify, for: indexPath) as! TNChooseRecvCell
            cell.selectionStyle = .none
            if (indexPath.row % 2 == 0)
            {
                cell.data = TNChooseRecvCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Thế Tân", content: "Phụ huynh")
            }else{
                cell.data = TNChooseRecvCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Thế Tân", content: "Phụ huynh")
            }
            return cell
        }
    }
}
