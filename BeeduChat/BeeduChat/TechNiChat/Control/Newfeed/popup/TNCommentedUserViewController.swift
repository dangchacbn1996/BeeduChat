//
//  TNInfoViewController.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNCommentedUserViewController : TNBaseViewController {
    
    //Content
    private var scrollView : UIScrollView!
    private var contentView : UIView!
    private var viewContainer : UIView!
    private var viewEmotion : UIView!
    private let contentRatio : CGFloat = 1.9
    private var contentPos : [CGFloat] = []
    private var startScrollY : CGFloat = 0
    private var tableMain = UITableView()
    var commentView = UIView()
    var avatarComment = UIButton()
    var index : Int = 0
    var tfComment = UITextField(text: "", placeholder: "Bình luận", textColor: Constant.text.color.black, font: nil)
    
    static func createInstance(index : Int) -> (TNCommentedUserViewController){
        let vc = TNCommentedUserViewController()
        vc.index = index
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        scrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentPos = [scrollView.contentSize.height * (contentRatio - 1) / contentRatio,
                      scrollView.contentSize.height * ((contentRatio - 1) / 2) / contentRatio,
                      0]
        print("EndDraging: \(contentPos)")
        print("EndDraging: Top: \(((contentPos[0] + contentPos[1]) / 2))")
        print("EndDraging: Middle: \((contentPos[1]) / 2)")
        scrollView.setContentOffset(CGPoint(x: 0, y: contentPos[0]), animated: true)
    }
    
    
    @objc func goBack(){
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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

extension TNCommentedUserViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let yOffset = scrollView.contentOffset.y
//        let isScrollUp = yOffset > startScrollY
        
//        if scrollView == self.scrollView {
//            if yOffset >= contentPos[0] && tableSeen.contentOffset.y <= 0 {
//                scrollView.isScrollEnabled = false
//                tableSeen.isScrollEnabled = true
//            }
            contentView.subviews[0].alpha = scrollView.contentOffset.y / (scrollView.contentSize.height / contentRatio)
            if (scrollView.contentOffset.y <= 0) {
                self.dismiss(animated: false, completion: nil)
            }
//        }
//
//        if scrollView == self.tableSeen {
//            print("tableOffset: \(isScrollUp)")
//            print("tableOffset: \(yOffset)")
//            print("tableOffset:-------------")
//            if yOffset <= 0 && isScrollUp == false {
//                self.scrollView.isScrollEnabled = true
//                self.tableSeen.isScrollEnabled = false
//            }
//        }
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        startScrollY = scrollView.contentOffset.y
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if (scrollView == self.scrollView) {
//            if (scrollView.contentOffset.y > ((contentPos[0] + contentPos[1]) / 2)) {
//                scrollView.setContentOffset(CGPoint(x: 0, y: contentPos[0]), animated: true)
//            } else if (scrollView.contentOffset.y < (contentPos[1]) / 2){
//                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//            } else {
//                scrollView.setContentOffset(CGPoint(x: 0, y: contentPos[1]), animated: true)
//            }
//        }
//    }
}

extension TNCommentedUserViewController : UITableViewDelegate {
    
}

extension TNCommentedUserViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return FixedData.newFeedData[index].comment[section].answer.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FixedData.newFeedData[index].comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data : TNCommentGeneralModel? = nil
        if (indexPath.row == 0) {
            data = FixedData.newFeedData[index].comment[indexPath.section].commentUser
        } else {
            data = FixedData.newFeedData[index].comment[indexPath.section].answer[indexPath.row - 1]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TNCommentCell.identify, for: indexPath) as! TNCommentCell
        cell.data = data!
        cell.delegate = self
        cell.layoutMargins = UIEdgeInsets(top: 0, left: Constant.size.paddingView, bottom: 0, right: Constant.size.paddingView)
        return cell
    }
}

extension TNCommentedUserViewController : TNCommentCellDelegate {
    func actCommentAnswer(_ gesture: UIGestureRecognizer) {
        let pos = gesture.location(in: self.tableMain)
        if let indexPath = self.tableMain.indexPathForRow(at: pos) {
            if (indexPath.row == 0) {
                tfComment.placeholder = "Trả lời \(FixedData.newFeedData[index].comment[indexPath.section].commentUser.name)"
            } else {
                tfComment.placeholder = "Trả lời \(FixedData.newFeedData[index].comment[indexPath.section].answer[indexPath.row - 1].name)"
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

extension TNCommentedUserViewController {
    func setupUI(){
        self.view.backgroundColor = .clear
        scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
        }
        contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalTo(self.view.snp.height).multipliedBy(self.contentRatio)
        }
        viewContainer = UIView()
        viewContainer.backgroundColor = .white
        contentView.addSubview(UIView()) { (back) -> (Void) in
            back.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.equalToSuperview()
            })
            back.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            back.alpha = 0
            back.isUserInteractionEnabled = true
            back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goBack)))
        }
        contentView.addSubview(viewContainer)
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalTo(self.view.frame.height * 0.9)
            maker.top.equalTo(contentView.subviews[0].snp.bottom)
            maker.centerX.width.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        self.contentView.addSubview(UIView()) { (indicator) -> (Void) in
            indicator.snp.makeConstraints({ (maker) in
                maker.centerX.equalToSuperview()
                maker.height.equalTo(6)
                maker.width.equalToSuperview().multipliedBy(0.3)
                maker.bottom.equalTo(self.viewContainer.snp.top).offset(-6)
            })
            indicator.clipsToBounds = true
            indicator.layer.cornerRadius = 3
            indicator.backgroundColor = .white
        }
        tableMain = UITableView()
        self.view.addSubview(commentView)
        avatarComment = ReuseForms.btnAvatar()
        commentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 16)
            maker.width.centerX.bottom.equalToSuperview()
        }
        commentView.backgroundColor = UIColor(238,238,238)
        commentView.layer.shadowColor = UIColor.gray.cgColor
        commentView.layer.shadowOpacity = 1
        commentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        commentView.layer.shadowRadius = 3.0
        commentView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 8, design: nil)) { (stackComment) -> (Void) in
            stackComment.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.height.equalToSuperview().offset(-16)
                maker.width.equalToSuperview().offset(-32)
            })
            (stackComment as! UIStackView).addArrangedSubview(self.avatarComment)
            
            (stackComment as! UIStackView).addArrangedSubview(
                UIView(background: UIColor(224,224,224), height: nil, ratioHW: nil, corner: Constant.size.avatarNormal / 2, border: 0, borderColor: nil, design: nil),
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
        viewEmotion = UIView()
        viewContainer.addSubview(viewEmotion)
        viewEmotion.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal)
            maker.top.centerX.width.equalToSuperview()
        }
        viewEmotion.addSubview(UIButton()) { (icLike) -> (Void) in
            (icLike as! UIButton).setImage(UIImage(named: "Header Arrow Back"), for: .normal)
            (icLike as! UIButton).imageView?.contentMode = .scaleAspectFit
            (icLike as! UIButton).addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goBack)))
            icLike.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.width.equalTo(icLike.snp.height)
                maker.leading.equalToSuperview().offset(Constant.size.paddingView)
                maker.height.equalToSuperview().multipliedBy(0.45)
            })
        }
        viewEmotion.addSubview(UIImageView(image: UIImage(named: "emoji_like"))) { (icLike) -> (Void) in
            icLike.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.width.equalTo(icLike.snp.height)
                maker.leading.equalTo(self.viewEmotion.subviews[0].snp.trailing).offset(4)
                maker.height.equalToSuperview().multipliedBy(0.55)
            })
        }
        viewEmotion.addSubview(UIImageView(image: UIImage(named: "emoji_haha"))) { (icHaha) -> (Void) in
            icHaha.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.width.equalTo(icHaha.snp.height)
                maker.leading.equalTo(self.viewEmotion.subviews[1].snp.trailing)
                maker.height.equalToSuperview().multipliedBy(0.55)
            })
        }
        viewEmotion.addSubview(UIImageView(image: UIImage(named: "emoji_heart"))) { (icHeart) -> (Void) in
            icHeart.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.width.equalTo(icHeart.snp.height)
                maker.leading.equalTo(self.viewEmotion.subviews[2].snp.trailing)
                maker.height.equalToSuperview().multipliedBy(0.55)
            })
        }
        viewEmotion.addSubview(UILabel(text: "và 20 người khác đã thích điều này", font: Constant.text.font.normal, textColor: Constant.text.color.black)) { (lbUser) -> (Void) in
            lbUser.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.leading.equalTo(self.viewEmotion.subviews[3].snp.trailing).offset(4)
            })
        }
        viewEmotion.addSubview(UIImageView(image: UIImage(named: "ic_like_hover"))) { (icHeart) -> (Void) in
            icHeart.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.width.equalTo(icHeart.snp.height)
                maker.trailing.equalToSuperview().offset(-Constant.size.paddingView)
                maker.leading.equalTo(self.viewEmotion.subviews[4].snp.trailing).offset(-8)
                maker.height.equalToSuperview().multipliedBy(0.55)
            })
        }
        viewEmotion.addSubview(UIView()) { (separate) -> (Void) in
            separate.snp.makeConstraints({ (maker) in
                maker.centerX.width.equalToSuperview()
                maker.bottom.equalToSuperview().offset(-1)
                maker.height.equalTo(Constant.size.separatorHeight)
            })
            separate.backgroundColor = Constant.color.separate
        }
        viewContainer.addSubview(tableMain)
        tableMain.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.viewContainer.subviews[0].snp.bottom)
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
    
//    func setupUserInfo(){
//        naviViewCenter = UIView()
//        setNavigation(image: UIImage(named: "ic_back"), leftAction: UITapGestureRecognizer(target: self, action: #selector(goBack)))
//        naviViewCenter!.snp.makeConstraints({ (maker) in
//            maker.centerY.height.equalToSuperview()
//            maker.trailing.equalToSuperview()
//            maker.leading.equalTo(naviBtnLeft.snp.trailing).offset(8)
//        })
//        naviViewCenter!.addSubview(stackHead)
//        stackHead.snp.makeConstraints { (maker) in
//            maker.height.equalTo(Constant.size.avatarNormal)
//            maker.width.equalToSuperview().offset(-Constant.size.paddingView)
//        }
//        stackHead.addArrangedSubview(ivAvatar)
//        ivAvatar.contentMode = .scaleAspectFill
//
//        ivAvatar.snp.makeConstraints { (maker) in
//            maker.width.equalTo(self.ivAvatar.snp.height)
//            maker.height.equalTo(Constant.size.avatarNormal)
//        }
//        ivAvatar.clipsToBounds = true
//        ivAvatar.layer.cornerRadius = Constant.size.avatarNormal / 2
//
//        stackHead.addArrangedSubview(UIView()) { (viewInfo) -> (Void) in
//            viewInfo.snp.makeConstraints({ (maker) in
//                maker.height.equalToSuperview()
//            })
//            viewInfo.addSubview(
//                self.lbUserName,
//                design: {
//                    (lbUser) -> (Void) in
//                    lbUser.snp.makeConstraints({ (maker) in
//                        maker.top.trailing.equalToSuperview()
//                        maker.leading.equalToSuperview().offset(4)
//                        maker.height.equalTo(Constant.size.avatarNormal / 2)
//                    })
//            })
//            viewInfo.addSubview(self.lbClass)
//            self.lbClass.snp.makeConstraints({ (maker) in
//                maker.leading.equalTo(viewInfo.subviews[0].snp.leading)
//                maker.height.equalTo(Constant.size.avatarNormal / 2)
//                maker.top.equalTo(viewInfo.subviews[0].snp.bottom)
//            })
//            viewInfo.addSubview(UIView(), design: { (separate) -> (Void) in
//                separate.backgroundColor = Constant.color.separate
//                separate.snp.makeConstraints({ (maker) in
//                    maker.width.equalTo(Constant.size.separatorHeight)
//                    maker.leading.equalTo(viewInfo.subviews[1].snp.trailing).offset(4)
//                    maker.centerY.equalTo(viewInfo.subviews[1].snp.centerY)
//                    maker.height.equalTo((viewInfo.subviews[1] as! UILabel).font.lineHeight)
//                })
//            })
//            viewInfo.addSubview(self.lbTimePost)
//            self.lbTimePost.snp.makeConstraints({ (maker) in
//                maker.leading.equalTo(viewInfo.subviews[2].snp.trailing).offset(4)
//                maker.centerY.height.equalTo(viewInfo.subviews[1])
//            })
//        }
//
//        stackHead.addArrangedSubview(btnPin)
//        btnPin.imageView?.contentMode = .scaleAspectFit
//        btnPin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actPostPin(_:))))
//        btnPin.snp.makeConstraints({ (maker) in
//            maker.width.equalTo(btnPin.snp.height).multipliedBy(0.5)
//            maker.width.equalTo(Constant.size.btnIcon)
//        })
//
//        stackHead.addArrangedSubview(btnMore)
//        btnMore.setImage(UIImage(named: "ic_more_horizon"), for: .normal)
//        btnMore.imageView?.contentMode = .scaleAspectFit
//        btnMore.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actPostMore(_:))))
//        btnMore.snp.makeConstraints({ (maker) in
//            maker.width.equalTo(btnMore.snp.height).multipliedBy(0.7)
//            maker.width.equalTo(Constant.size.btnIcon)
//        })
//    }
}
