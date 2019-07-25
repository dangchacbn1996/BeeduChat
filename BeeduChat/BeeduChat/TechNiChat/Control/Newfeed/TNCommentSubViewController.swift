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
    var index = 0
    
    static func createInstance(index : Int) -> (TNCommentSubViewController){
        let vc = TNCommentSubViewController()
        vc.index = index
        return vc
    }

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
    
    func reloadData(){
        tableComment.reloadData()
    }
    
//    func scrollToBottom(){
//        let current = FixedData.newFeedData[index]
//        tableComment.scrollToRow(at: IndexPath(row: current.comment[current.comment.count - 1].answer.count - 1, section: current.comment.count - 1), at: .middle, animated: true)
////        tableComment.scrollToRow(at: IndexPath(row: <#T##Int#>, section: <#T##Int#>), at: <#T##UITableView.ScrollPosition#>, animated: <#T##Bool#>)
//    }
    
}

extension TNCommentSubViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return FixedData.newFeedData[index].comment.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNCommentCell.identify) as! TNCommentCell
        cell.selectionStyle = .none
        cell.data = FixedData.newFeedData[index].comment[section].commentUser
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FixedData.newFeedData[index].comment[section].answer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNCommentCell.identify, for: indexPath) as! TNCommentCell
        cell.selectionStyle = .none
        cell.data = FixedData.newFeedData[index].comment[indexPath.section].answer[indexPath.row]
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
