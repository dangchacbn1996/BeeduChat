//
//  CommentSubViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class CommentSubViewController: UIViewController {
    
    var tableComment = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension CommentSubViewController {
    func setupUI(){
        tableComment = UITableView()
        self.view.addSubview(tableComment)
        tableComment.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
        }
    }
}
