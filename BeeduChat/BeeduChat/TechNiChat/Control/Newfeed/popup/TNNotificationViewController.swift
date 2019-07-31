//
//  TNNotificationViewController.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/31/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class TNNotificationViewController : TNBaseViewController {
    
    var tableView = UITableView()
    var data = [TNNotifiMode(header: "Đã đọc", content: "Gửi cho 20 người", status: .complete, percent: 20),
                TNNotifiMode(header: "Đã gửi", content: "Gửi cho 10 người", status: .processing, percent: 20),
                TNNotifiMode(header: "Bố Lan Ngọc", content: "Gửi lỗi", status: .cancel, percent: 20)]

    override func viewDidLoad() {
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(TNNotifiTVCell.self, forCellReuseIdentifier: TNNotifiTVCell.identify)
    }
    
    @objc func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TNNotificationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNNotifiTVCell.identify, for: indexPath) as! TNNotifiTVCell
        cell.data = data[indexPath.row]
        return cell
    }
}

extension TNNotificationViewController {
    func setupUI(){
        self.view.backgroundColor = .white
        naviViewCenter = UIView()
        self.view.addSubview(tableView)
        setNavigation(image: UIImage(named: "Header Arrow Back"), leftAction: UITapGestureRecognizer(target: self, action: #selector(goBack)))
        naviViewCenter!.snp.makeConstraints({ (maker) in
            maker.center.height.equalToSuperview()
            maker.leading.equalTo(naviBtnLeft.snp.trailing).offset(4)
        })
        naviViewCenter?.addSubview(UILabel(text: "Thống kê báo cáo", textColor: Constant.text.color.black, font: Constant.text.font.customFont(size: Constant.text.size.normal, weight: .Bold)), design: { (lbThongKe) -> (Void) in
            lbThongKe.snp.makeConstraints({ (maker) in
                maker.centerX.equalToSuperview()
            })
        })
        naviViewCenter?.addSubview(UILabel(text: "Gửi cho 20 người", textColor: Constant.text.color.black, font: nil), design: { (lbThongKe) -> (Void) in
            lbThongKe.snp.makeConstraints({ (maker) in
                maker.centerX.equalToSuperview()
                maker.bottom.equalToSuperview().offset(-8)
                maker.top.equalTo(self.naviViewCenter!.subviews[0].snp.bottom).offset(4)
            })
        })
        naviSeparate.alpha = 1
        
        tableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.navigation.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
        }
    }
}
