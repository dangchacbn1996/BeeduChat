//
//  NewGroupViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNNewGroupViewController: TNBaseViewController {

    var naviConstraint : NSLayoutConstraint!
//    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var btnBack = UIButton()
    var lblTitle = UILabel(text: "Tạo nhóm", textColor: Constant.text.color.black, font: nil)
    var searchView = UIView()
    var txtSearch = UITextField(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var contactView = UIView()
    var lblMember = UILabel(text: "Chọn", textColor: .black, font: nil)
    var btnSave = UILabel(text: "Tiếp tuc", textColor: UIColor.blue, font: nil)
    var contenView = UIView()
    var tbvContentView = UITableView()
//    var ceparateView = UIView()
    var historyView = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        tbvContentView.register(TNChooseRecvCell.self, forCellReuseIdentifier: TNChooseRecvCell.identify)
        tbvContentView.tableFooterView = UIView()
        tbvContentView.tableHeaderView = UIView()
        tbvContentView.showsVerticalScrollIndicator = false
        //        tbvChat.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tbvContentView.separatorStyle = .singleLine
        tbvContentView.delegate = self
        tbvContentView.dataSource = self
        
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        edgeGes.edges = .left
        self.view.addGestureRecognizer(edgeGes)
    }
    @objc func goBack(){
        Constant.animationTo(view : self, type : .dismiss)
        self.dismiss(animated: false, completion: nil)
    }
}

extension TNNewGroupViewController{
    func setupUI(){
        UINavBar()
//        addCeparate()
        UISearchBar()
        UIHisContactBar()
        UIContentView()
    }
    func UINavBar(){
//        self.view.backgroundColor = UIColor.white
//        self.navigationController?.navigationBar.isHidden = true
//
//        self.view.addSubview(navigationView)
//        //        navigationView.dropShadow(scale : true)
//        //        navigationView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
//        navigationView.snp.makeConstraints { (maker) in
//            maker.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
//            maker.width.equalToSuperview()
//            //            maker.height.equalTo(Constant.size.naviHeight)
//        }
//        naviConstraint = navigationView.heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
//        naviConstraint.isActive = true
//        /* Navigation
//         **************************************
//         * Menu         Class       noti more *
//         **************************************
//         */
//        navigationView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)) { (stackNavi) -> (Void) in
//            stackNavi.snp.makeConstraints({ (maker) in
//                maker.center.equalToSuperview()
//                maker.height.equalToSuperview().offset(-2 * Constant.size.padding)
//                maker.width.equalToSuperview().offset(-2 * Constant.size.padding)
//            })
//            //Btn menu
//            (stackNavi as! UIStackView).addArrangedSubview(self.btnBack)
//            self.btnBack.snp.makeConstraints({ (maker) in
//                maker.width.equalTo(self.btnBack.snp.height)
//                maker.height.equalTo(Constant.size.btnIcon)
//            })
//            self.btnBack.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
//            self.btnBack.tintColor = Constant.color.iconColor
//            self.btnBack.contentMode = .scaleAspectFit
//            //            self.btnMenu.backgroundColor = UIColor.blue
//
//            //Ten lop
//            (stackNavi as! UIStackView).addArrangedSubview(UIView())
//
//            self.navigationView.addSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil), design: { (stackClass) -> (Void) in
//                stackClass.snp.makeConstraints({ (maker) in
//                    maker.center.equalToSuperview()
//                    //                    maker.height.equalToSuperview()
//
//                })
//                (stackClass as! UIStackView).addArrangedSubview(self.lblTitle)
//                self.lblTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
//            })
//            //Btn noti
//            (stackNavi as! UIStackView).addArrangedSubview(self.btnSave)
//            self.btnSave.snp.makeConstraints({ (maker) in
////                maker.width.equalTo(self.btnSave.snp.height).multipliedBy(0.8)
//                maker.height.equalTo(Constant.size.btnIcon)
//            })
//
//        }
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        naviBtnRight = UIButton(frame: .zero)
        naviBtnRight!.setTitle("Tiếp tục", for: .normal)
        naviBtnRight?.setTitleColor(Constant.text.color.blue, for: .normal)
        naviBtnRight?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        
        naviLbTitle = UILabel(text: "Tạo nhóm",
                              textColor: Constant.text.color.black,
                              font: Constant.text.font.customFont(
                                size: Constant.text.size.large,
                                weight: .Bold
        ))
        setNavigation(image: UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), leftAction: UITapGestureRecognizer(target: self, action: #selector(goBack)))
        naviSeparate.alpha = 1
    }
//    func addCeparate(){
//        self.view.addSubview(ceparateView)
//        ceparateView.snp.makeConstraints { (maker) in
//            maker.height.equalTo(1)
//            maker.width.equalToSuperview()
//            maker.top.equalTo(navigation.snp.bottom)
//            maker.centerX.equalToSuperview()
//        }
//        ceparateView.backgroundColor = UIColorFromRGB(rgbValue: 0x363636)
//    }
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigation.snp.height).offset(-24)
            maker.width.equalTo(navigation.snp.width).offset(-32)
            maker.top.equalTo(naviSeparate.snp.bottom).offset(16)
            maker.centerX.equalTo(navigation.snp.centerX)
        }
        searchView.addSubview(UIView(background: UIColorFromRGB(rgbValue: 0xf3f3f3), corner: Constant.size.avatarNormal / 2, border: 0, borderColor: Constant.color.separate, design: nil)) { (srcView) -> (Void) in
            srcView.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
                maker.center.equalToSuperview()
            })
            //add text field
            srcView.addSubview(self.txtSearch)
            self.txtSearch.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview().multipliedBy(0.7)
                maker.centerY.equalToSuperview()
                maker.left.equalToSuperview().offset(8)
                maker.right.equalToSuperview().offset(-8)
            })
            self.txtSearch.placeholder = "Nhập tên số, điện thoại, email"
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
        historyView.backgroundColor = UIColor.green
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
                collection.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
                (collection as! UICollectionView).delegate = self
                (collection as! UICollectionView).dataSource = self
                (collection as! UICollectionView).collectionViewLayout = UICollectionViewFlowLayout()
                (collection as! UICollectionView).register(TNUserChatCVC.self, forCellWithReuseIdentifier: TNUserChatCVC.identify)
            })
        }
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
    func UIContentView(){
        self.view.addSubview(contenView)
        contenView.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.width.equalTo(navigation.snp.width).offset(-32)
            maker.top.equalTo(historyView.snp.bottom).offset(16)
            maker.centerX.equalTo(historyView.snp.centerX)
        }
        contenView.addSubview(lblMember)
        lblMember.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblMember.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        contenView.addSubview(tbvContentView)
        tbvContentView.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblMember.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
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
extension TNNewGroupViewController : UICollectionViewDelegate, UICollectionViewDataSource{
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
        //        return UITableView.automaticDimension
    }
}
extension TNNewGroupViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = BasicExampleViewController()
            self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
