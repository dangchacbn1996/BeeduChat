//
//  TNInfoViewController.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNInfoViewController : TNBaseViewController {
    
    var tableMain : UITableView!
    var commentView = UIView()
    var avatarComment = UIButton()
    var index : Int = 0
    var pin = false
    var tfComment = UITextField(text: "", placeholder: "Bình luận", textColor: Constant.text.color.black, font: nil)
    
    static func createInstance(index : Int) -> (TNInfoViewController){
        let vc = TNInfoViewController()
        vc.index = index
        return vc
    }
    
    override func viewDidLoad() {
        setupUI()
    }
    
    @objc func goBack(){
        self.dismissTrans()
    }
    
    @objc func addComment(){
        if (tfComment.text != "") {
            let time = ""
            let dateType = DateFormatter()
            dateType.dateFormat = "hh:mm"
            FixedData.newFeedData[index].comment.append(TNCommentModel(commentUser: TNCommentGeneralModel(avatar: UIImage(named: FixedData.userAvatar), name: FixedData.user, time: dateType.string(from: Date()), content: tfComment.text!, isAnswer: false), answer: []))
            tfComment.text = ""
            self.view.endEditing(true)
            tableMain.reloadData()
        }
    }
}

extension TNInfoViewController : UITableViewDelegate {
    
}

extension TNInfoViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        return FixedData.newFeedData[index].comment[section - 1].answer.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if (section == 0) {
//            return nil
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: TNCommentCell.identify) as! TNCommentCell
//        cell.selectionStyle = .none
//        cell.delegate = self
//        cell.data = FixedData.newFeedData[index].comment[section - 1].commentUser
//        return cell
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + FixedData.newFeedData[index].comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TNPostInfoCell.identify, for: indexPath) as! TNPostInfoCell
            cell.data = FixedData.newFeedData[index]
            cell.delegate = self
            cell.hideSeparate = true
            cell.isPin = pin
            return cell
        }
        var data : TNCommentGeneralModel? = nil
        if (indexPath.row == 0) {
            data = FixedData.newFeedData[index].comment[indexPath.section - 1].commentUser
        } else {
            data = FixedData.newFeedData[index].comment[indexPath.section - 1].answer[indexPath.row - 1]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TNCommentCell.identify, for: indexPath) as! TNCommentCell
        cell.data = data!
        cell.delegate = self
        cell.layoutMargins = UIEdgeInsets(top: 0, left: Constant.size.paddingView, bottom: 0, right: Constant.size.paddingView)
        return cell
    }
}

extension TNInfoViewController : TNCommentCellDelegate {
    func actCommentAnswer(_ gesture: UIGestureRecognizer) {
        let pos = gesture.location(in: self.tableMain)
        if let indexPath = self.tableMain.indexPathForRow(at: pos) {
            if (indexPath.row == 0) {
                tfComment.placeholder = "Trả lời \(FixedData.newFeedData[index].comment[indexPath.section - 1].commentUser.name)"
            } else {
                tfComment.placeholder = "Trả lời \(FixedData.newFeedData[index].comment[indexPath.section - 1].answer[indexPath.row - 1].name)"
            }
        }
    }
    
    func actCommentLike(_ gesture: UIGestureRecognizer) {
        let pos = gesture.location(in: self.tableMain)
        if let indexPath = self.tableMain.indexPathForRow(at: pos) {
            let cell = tableMain.cellForRow(at: indexPath) as? TNCommentCell
            cell?.hasLike = !(cell?.hasLike ?? false)
        }
    }
}

extension TNInfoViewController : TNPostInfoDelegate {
    func actPostMore(_ gesture: UIGestureRecognizer) {
        let view = TNActionSheetViewController()
        view.modalPresentationStyle = .overCurrentContext
        view.data = [TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1")]
        self.present(view, animated: false, completion: nil)
    }
    
    func actPostImageView(_ gesture: UIGestureRecognizer) {
        let view = TNLibraryImageViewController()
        view.modalPresentationStyle = .overCurrentContext
        self.present(view, animated: false, completion: nil)
        view.data = FixedData.newFeedData[index].image
    }
    
    func actPostPin(_ gesture: UIGestureRecognizer) {
        pin = !pin
        tableMain.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    func actPostEmoji(_ gesture: UIGestureRecognizer) {
        let view = TNSeenUserViewController()
        view.modalPresentationStyle = .overCurrentContext
        self.present(view, animated: false, completion: nil)
        view.data = FixedData.newFeedData[index].emotion
    }
    
    func actPostEmotion(_ gesture: UIGestureRecognizer) {
        var isActed = false
        for ind in 0..<FixedData.newFeedData[index].emotion.count {
            if (FixedData.newFeedData[index].emotion[ind].userName == FixedData.user) {
                FixedData.newFeedData[index].emotion.remove(at: ind)
                isActed = true
                break
            }
        }
        if (!isActed) {
            FixedData.newFeedData[index].emotion.append(TNEmotionModel(emote: .like, userName: FixedData.user, userAvatar: FixedData.userAvatar))
        }
        tableMain.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    func actPostAvatar(_ gesture: UIGestureRecognizer) {
        print("Pin avatar")
    }
}

extension TNInfoViewController {
    func setupUI(){
        setNavigation(image: UIImage(named: "ic_back"), leftAction: UITapGestureRecognizer(target: self, action: #selector(goBack)))
        naviSeparate.alpha = 1
        
        avatarComment = ReuseForms.btnAvatar()
        self.view.addSubview(commentView)
        commentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 16)
            maker.width.centerX.bottom.equalToSuperview()
        }
        commentView.backgroundColor = UIColor.white
        commentView.layer.shadowColor = UIColor.gray.cgColor
        commentView.layer.shadowOpacity = 0.5
        commentView.layer.shadowOffset = CGSize(width: 0, height: -1)
        commentView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackComment) -> (Void) in
            stackComment.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.height.equalToSuperview().offset(-16)
                maker.width.equalToSuperview().offset(-32)
            })
            (stackComment as! UIStackView).addArrangedSubview(self.avatarComment)
            
            (stackComment as! UIStackView).addArrangedSubview(
                UIView(background: UIColor.gray.withAlphaComponent(0.4), height: nil, ratioHW: nil, corner: Constant.size.avatarNormal / 2, border: 0, borderColor: nil, design: nil),
                design: { (container) -> (Void) in
                    container.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
                    container.addSubview(self.tfComment)
                    self.tfComment.snp.makeConstraints({ (maker) in
                        maker.center.equalToSuperview()
                        maker.size.equalToSuperview().offset(-16)
                    })
            })
            
            (stackComment as! UIStackView).addArrangedSubview(UIButton(frame: .zero), design: { (btnSend) -> (Void) in
                btnSend.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
                (btnSend as! UIButton).setTitle("Send", for: .normal)
                (btnSend as! UIButton).setTitleColor(Constant.text.color.blue, for: .normal)
                btnSend.isUserInteractionEnabled = true
                btnSend.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addComment)))
            })
        }
        
        tableMain = UITableView()
        self.view.addSubview(tableMain)
        tableMain.snp.makeConstraints { (maker) in
            maker.top.equalTo(navigation.snp.bottom)
            maker.centerX.width.equalToSuperview()
            maker.bottom.equalTo(commentView.snp.top)
        }
        tableMain.delegate = self
        tableMain.dataSource = self
        tableMain.register(TNPostInfoCell.self, forCellReuseIdentifier: TNPostInfoCell.identify)
        tableMain.register(TNCommentCell.self, forCellReuseIdentifier: TNCommentCell.identify)
        tableMain.separatorStyle = .none
        tableMain.allowsSelection = false
    }
}
