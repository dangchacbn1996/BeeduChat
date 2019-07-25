//
//  NewFeedViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNPostInfoViewController: TNBaseViewController {
    var btnMenu = UIButton()
    var btnNoti = UIButton()
    var btnMore = UIButton()
    var lbClass = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    var lbSubClass = UILabel(text: "@fox.class", textColor: Constant.text.color.black, font: nil)
    var scrollMain = UIScrollView()
    var stackMain = UIStackView(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 0, design: nil)
    var tableView = UITableView()
    var commentView = UIView()
    var avatarComent = ReuseForms.imageAvatar()
    var tfComment = UITextField(text: "", placeholder: "Viết bình luận", textColor: Constant.text.color.black, font: nil)
    var newFeedView = UIView(background: UIColor.white, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: nil, design: nil)
    var index = 0
    var postInfoView = UIView()
    var content : TNCommentViewController!
    
    static func createInstance(index : Int) -> (TNPostInfoViewController){
        let vc = TNPostInfoViewController()
        vc.index = index
        return vc
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        edgeGes.edges = .left
        self.view.addGestureRecognizer(edgeGes)
    }
    
    @objc func goBack(){
        Constant.animationTo(view : self, type : .dismiss)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func avatarTap(_ gesture : UITapGestureRecognizer){
//        let pos = gesture.location(in: self.tablePost)
//        let indexPath = self.tablePost.indexPathForRow(at: pos)
        print("AvatarTap : Avatar")
    }
    
    @objc func tapLike(_ gesture : UITapGestureRecognizer){
        var isActed = false
        for count in 0..<FixedData.newFeedData[index].emotion.count {
            if (FixedData.newFeedData[index].emotion[count].userName == FixedData.user) {
                FixedData.newFeedData[index].emotion.remove(at: count)
                isActed = true
                break
            }
        }
        if (!isActed) {
            FixedData.newFeedData[index].emotion.append(TNEmotionModel(emote: .like, userName: FixedData.user, userAvatar: FixedData.userAvatar))
        }
        reloadData()
    }
    
    @objc func tapEmoji(_ gesture : UITapGestureRecognizer){
        let view = TNSeenUserViewController()
        view.modalPresentationStyle = .overCurrentContext
        self.present(view, animated: true, completion: nil)
        view.data = FixedData.newFeedData[index].emotion
    }
    
    func reloadData(){
        postInfoView = TNPostView.postView(FixedData.newFeedData[index],
                                           actAvatar: UITapGestureRecognizer(target: self, action: #selector(avatarTap(_:))),
                                           actLike: UITapGestureRecognizer(target: self, action: #selector(tapLike(_:))),
                                           actEmoji: UITapGestureRecognizer(target: self, action: #selector(tapEmoji(_:))))
    }
    
    @objc func addComment(){
        if (tfComment.text != "") {
            let time = ""
            let dateType = DateFormatter()
            dateType.dateFormat = "hh:mm"
            FixedData.newFeedData[index].comment.append(TNCommentModel(commentUser: TNCommentGeneralModel(avatar: UIImage(named: FixedData.userAvatar), name: FixedData.user, time: dateType.string(from: Date()), content: tfComment.text!, isAnswer: false), answer: []))
            tfComment.text = ""
            content.reloadData()
            self.view.endEditing(true)
        }
    }
}

extension TNPostInfoViewController{
    
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        naviLbTitle = UILabel(text: FixedData.newFeedData[index].username,
                              textColor: Constant.text.color.black,
                              font: Constant.text.font.customFont(
                                size: Constant.text.size.large,
                                weight: .Bold
        ))
        setNavigation(image: UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), leftAction: UITapGestureRecognizer(target: self, action: #selector(goBack)))
        
        self.view.addSubview(stackMain)
        self.view.addSubview(commentView)
//        scrollMain.snp.makeConstraints { (maker) in
//            maker.leading.trailing.equalToSuperview()
//            maker.top.equalTo(navigation.snp.bottom)
//            maker.bottom.equalTo(commentView.snp.top)
//            maker.width.equalToSuperview()
//        }
        commentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(Constant.size.avatarNormal + 16)
            maker.width.centerX.bottom.equalToSuperview()
        }
//        scrollMain.addSubview(stackMain)
        stackMain.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(navigation.snp.bottom)
            maker.bottom.equalTo(commentView.snp.top)
//            maker.top.leading.trailing.bottom.equalToSuperview()
//            maker.width.equalToSuperview()
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
            (stackComment as! UIStackView).addArrangedSubview(self.avatarComent)
            
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
        
        reloadData()
        self.stackMain.addArrangedSubview(self.postInfoView)
        
        self.stackMain.addArrangedSubview(UIView()) { (separateView) -> (Void) in
            separateView.addSubview(UIView(), design: { (separate) -> (Void) in
                separate.backgroundColor = Constant.color.separate
                separate.snp.makeConstraints({ (maker) in
                    maker.width.centerX.equalToSuperview()
                    maker.top.equalToSuperview().offset(4)
                    maker.height.equalTo(Constant.size.separatorHeight)
                })
            })
        }
        
        content = TNCommentViewController.createInstance(index : index)
        self.addChild(content)
        content.didMove(toParent: self)
        self.stackMain.addArrangedSubview(content.view)
//        scrollMain.contentSize = stackMain.intrinsicContentSize
    }
}
