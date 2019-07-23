//
//  ReportViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/8/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNReportViewController: UIViewController {
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var stackviewTitle = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil)
    var btnMenu = UIButton()
    var lblClass = UILabel(text: "Thống kê báo cáo", textColor: Constant.text.color.black, font: nil)
    var lblSubClass = UILabel(text: "Gửi cho 20 người", textColor: Constant.text.color.gray, font: nil)
    var contentView = UIView()
    var tbvContent = UITableView()
    var ceparateView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        tbvContent.dataSource = self
        tbvContent.delegate = self
        tbvContent.register(TNReportCell.self, forCellReuseIdentifier: TNReportCell.identifier)
        tbvContent.tableFooterView = UIView()
        tbvContent.tableHeaderView = UIView()
        tbvContent.separatorStyle = .singleLine
        // Do any additional setup after loading the view.
    }

}
extension TNReportViewController{
    func SetupUI(){
        UINavBar()
        addCeparate()
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
        self.btnMenu.tintColor = Constant.color.iconColor
        //        btnMenu.backgroundColor = UIColor.blue
        
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
//        stackviewTitle.snp.makeConstraints { (maker) in
//            maker.height.equalToSuperview().multipliedBy(1)
//        }
//        //add lable class name
//        stackviewTitle.addArrangedSubview(lblClass)
//        stackviewTitle.addArrangedSubview(lblSubClass)
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
extension TNReportViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return Constant.size.rowHeightChat
//        return UITableView.automaticDimension
    }
}
extension TNReportViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNReportCell.identifier, for: indexPath) as! TNReportCell
        cell.selectionStyle = .none
        if (indexPath.row % 2 == 0) {
            cell.data = TNReportCellModel(title: "Đã đọc", subTitle: "Có 2 người đã xem", iconStt: UIImage(named: "checked"), percent: "10%", btnAction: UIImage(named: "ic_right"))
        } else {
            cell.data = TNReportCellModel(title: "Đã đọc", subTitle: "Có 2 người đã xem", iconStt: UIImage(named: "check"), percent: "10%", btnAction: UIImage(named: "ic_right"))
        }
        return cell
    }
}