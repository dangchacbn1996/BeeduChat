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
        PostView.navigationView(parent: self.view)
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
