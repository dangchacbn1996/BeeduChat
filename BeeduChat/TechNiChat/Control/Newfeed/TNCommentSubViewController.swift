//
//  CommentSubViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

struct TNCommentModel {
    var commentUser : TNCommentGeneralModel = TNCommentGeneralModel()
    var answer : [TNCommentGeneralModel] = []
}

class TNCommentSubViewController: UIViewController {
    
    var tableComment = UITableView()
    var data = [
        TNCommentModel(commentUser: TNCommentGeneralModel(avatar: nil, name: "Master1", time: "12:30", content: "Comment", isAnswer: false), answer: [
            TNCommentGeneralModel(avatar: nil, name: "User", time: "12:31", content: "SubComment", isAnswer: true),
            TNCommentGeneralModel(avatar: nil, name: "User2", time: "12:32", content: "A TableView solves the line problem, but it seems like a lot of work for such a simple layout", isAnswer: true),
            TNCommentGeneralModel(avatar: nil, name: "User", time: "12:33", content: "SubComment4342", isAnswer: true)
            ]
        ),
        TNCommentModel(commentUser: TNCommentGeneralModel(avatar: nil, name: "Master2", time: "12:30", content: "Comment", isAnswer: false), answer: [
            TNCommentGeneralModel(avatar: nil, name: "User", time: "12:31", content: "SubComment", isAnswer: true),
            TNCommentGeneralModel(avatar: nil, name: "User2", time: "12:32", content: "SubComment123", isAnswer: true),
            TNCommentGeneralModel(avatar: nil, name: "User", time: "12:33", content: "SubComment4342", isAnswer: true)
            ]
        ),
        TNCommentModel(commentUser: TNCommentGeneralModel(avatar: nil, name: "Master3", time: "12:30", content: "Comment", isAnswer: false), answer: [
            TNCommentGeneralModel(avatar: nil, name: "User", time: "12:31", content: "SubComment", isAnswer: true),
            TNCommentGeneralModel(avatar: nil, name: "User2", time: "12:32", content: "SubComment123", isAnswer: true),
            TNCommentGeneralModel(avatar: nil, name: "User", time: "12:33", content: "SubComment4342", isAnswer: true)
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        tableComment.dataSource = self
        tableComment.delegate = self
        tableComment.register(TNCommentCell.self, forCellReuseIdentifier: TNCommentCell.identify)
        tableComment.isScrollEnabled = true
        tableComment.tableFooterView = UIView()
        tableComment.separatorStyle = .none
    }
    
    override func viewWillLayoutSubviews() {
        tableComment.snp.makeConstraints { (maker) in
            maker.height.equalTo(self.tableComment.contentSize.height)
        }
    }
    
}

extension TNCommentSubViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNCommentCell.identify) as! TNCommentCell
        cell.selectionStyle = .none
        cell.data = data[section].commentUser
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].answer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNCommentCell.identify, for: indexPath) as! TNCommentCell
        cell.selectionStyle = .none
        cell.data = data[indexPath.section].answer[indexPath.row]
        return cell
    }
}


extension TNCommentSubViewController {
    func setupUI(){
        tableComment = UITableView()
        self.view.addSubview(tableComment)
        tableComment.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
        }
    }
}
