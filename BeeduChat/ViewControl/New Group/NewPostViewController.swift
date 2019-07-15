//
//  NewPostViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class NewPostViewController : UIViewController {
    
    let btnMenu = UIButton()
    let btnFunction = UIButton()
    let btnMore = UIButton()
    let lbTitle = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    let lbSubTitle = UILabel(text: "@fox.class", textColor: Constant.text.color.black, font: nil)
    var userInfoView : UIView!
    var tablePost = UITableView()
    
    override func viewDidLoad() {
        setupUI()
    }
    
}

extension NewPostViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewPostCell.identify, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

extension NewPostViewController {
    func setupUI(){
        self.view.backgroundColor = Constant.color.naviBack
        self.navigationController?.navigationBar.isHidden = true
//        PostView.navigationView(parent: self.view)
        PostView.navigationView(parent: self.view, lbTitle: lbTitle, lbSubTitle: lbSubTitle, btnMenu: btnMenu, btnFunction: btnFunction, btnMore: btnMore, actionMenu: nil, actionNotifi: nil, actionMore: nil)
        self.view.addSubview(tablePost)
        tablePost.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(self.view.subviews[1].snp.bottom)
        }
        tablePost.delegate = self
        tablePost.dataSource = self
        tablePost.separatorStyle = .none
        tablePost.register(NewPostCell.self, forCellReuseIdentifier: NewPostCell.identify)
    }
}
