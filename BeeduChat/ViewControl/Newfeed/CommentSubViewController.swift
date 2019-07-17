//
//  CommentSubViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

struct CommentModel {
    var commentUser : CommentGeneralModel = CommentGeneralModel()
    var answer : [CommentGeneralModel] = []
}

class CommentSubViewController: UIViewController {
    
    var tableComment = UITableView()
    var data = [CommentModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        data = [
            CommentModel(commentUser: CommentGeneralModel(avatar: nil, name: "Master1", time: "12:30", content: "Comment", isAnswer: false), answer: [
                CommentGeneralModel(avatar: nil, name: "User", time: "12:31", content: "SubComment", isAnswer: true),
                CommentGeneralModel(avatar: nil, name: "User2", time: "12:32", content: "A TableView solves the line problem, but it seems like a lot of work for such a simple layout", isAnswer: true),
                CommentGeneralModel(avatar: nil, name: "User", time: "12:33", content: "SubComment4342", isAnswer: true)
                ]
            ),
            CommentModel(commentUser: CommentGeneralModel(avatar: nil, name: "Master2", time: "12:30", content: "Comment", isAnswer: false), answer: [
                CommentGeneralModel(avatar: nil, name: "User", time: "12:31", content: "SubComment", isAnswer: true),
                CommentGeneralModel(avatar: nil, name: "User2", time: "12:32", content: "SubComment123", isAnswer: true),
                CommentGeneralModel(avatar: nil, name: "User", time: "12:33", content: "SubComment4342", isAnswer: true)
                ]
            ),
            CommentModel(commentUser: CommentGeneralModel(avatar: nil, name: "Master3", time: "12:30", content: "Comment", isAnswer: false), answer: [
                CommentGeneralModel(avatar: nil, name: "User", time: "12:31", content: "SubComment", isAnswer: true),
                CommentGeneralModel(avatar: nil, name: "User2", time: "12:32", content: "SubComment123", isAnswer: true),
                CommentGeneralModel(avatar: nil, name: "User", time: "12:33", content: "SubComment4342", isAnswer: true)
                ]
            )
        ]
        tableComment.dataSource = self
        tableComment.delegate = self
        tableComment.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identify)
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

extension CommentSubViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identify) as! CommentCell
        cell.selectionStyle = .none
        cell.data = data[section].commentUser
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].answer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identify, for: indexPath) as! CommentCell
        cell.selectionStyle = .none
        cell.data = data[indexPath.section].answer[indexPath.row]
        return cell
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
