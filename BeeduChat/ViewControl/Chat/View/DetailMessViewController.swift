//
//  DetailMessViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/8/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class DetailMessViewController: UIViewController {
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var stackviewTitle = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil)
    var btnMenu = UIButton()
    var lblClass = UILabel(text: "Đã đọc", textColor: Constant.text.color.black, font: nil)
    var lblSubClass = UILabel(text: "Có 2 người xem", textColor: Constant.text.color.gray, font: nil)
    var contentView = UIView()
    var tbvContent = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        // Do any additional setup after loading the view.
        tbvContent.delegate = self
        tbvContent.dataSource = self
        tbvContent.register(DetailMessageCell.self, forCellReuseIdentifier: DetailMessageCell.identify)
        tbvContent.tableFooterView = UIView()
        tbvContent.tableHeaderView = UIView()
        tbvContent.separatorStyle = .none
    }

}

extension DetailMessViewController{
    func SetupUI(){
        UINavBar()
        UIContent()
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
        //        navigationView.backgroundColor = UIColor.blue
        // add stack view to navigationView
        navigationView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.center.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
        //add button menu to stackView
        stackView.addArrangedSubview(self.btnMenu)
        btnMenu.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnMenu.snp.width)
            maker.height.equalToSuperview().multipliedBy(0.8)
        }
        self.btnMenu.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnMenu.contentMode = .scaleAspectFit
        //        btnMenu.backgroundColor = UIColor.blue
        //add stackview Tittle lalbe
        stackView.addArrangedSubview(stackviewTitle)
        stackviewTitle.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview().multipliedBy(1)
        }
        //add lable class name
        stackviewTitle.addArrangedSubview(lblClass)
        stackviewTitle.addArrangedSubview(lblSubClass)
    }
    func UIContent(){
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(navigationView.snp.bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp.centerX)
        }
        contentView.addSubview(tbvContent)
        tbvContent.snp.makeConstraints { (maker) in
            maker.height.width.centerX.equalToSuperview()
        }
        tbvContent.backgroundColor = UIColor.blue
    }
}

extension DetailMessViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension DetailMessViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailMessageCell.identify, for: indexPath) as! DetailMessageCell
        cell.selectionStyle = .none
        if(indexPath.row % 2 == 0){
            cell.data = DetailMessageCellModel(avatar: UIImage(named: "ic_ava"), nameID: "Bố Trường Giang")
        }
        else{
            cell.data = DetailMessageCellModel(avatar: UIImage(named: "ic_ava"), nameID: "Bố Thế Tân")
        }
        return cell
    }
}
