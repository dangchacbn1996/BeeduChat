//
//  NewPostViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNNewFeedViewController : TNBaseViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var naviConstraint : NSLayoutConstraint!
    var naviLastOffset : CGFloat = 0
    var naviLastHeight : CGFloat = Constant.size.naviHeight
    let btnMenu = UIButton()
    let btnFunction = UIButton()
    let btnMore = UIButton()
    let lbTitle = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    let lbSubTitle = UILabel(text: "@fox.class", textColor: Constant.text.color.black, font: nil)
    var userInfoView : UIView!
    var tablePost = UITableView()
    var pinList : [Int] = []
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        setupUI()
    }
    
    @objc func scrollNew(){
        tablePost.setContentOffset(.zero, animated: true)
    }
    
    @objc func openNotifi(){
        let vc = TNNotificationViewController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func newPost(){
        let vc = TNNewPostViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnClicked() {
        
        TNImagePickerManager().pickImage(self){ image in
            //here is the image
            let view = TNLibraryImageViewController()
            view.modalPresentationStyle = .overCurrentContext
            self.present(view, animated: false, completion: nil)
            view.imageView.image = image
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        print("PickImage")
//        imageView.image = image
    }
}

extension TNNewFeedViewController : TNRefreshDelegate {
    func refreshData() {
        tablePost.reloadData()
    }
}

extension TNNewFeedViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FixedData.newFeedData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TNNewPostCell.identify, for: indexPath) as! TNNewPostCell
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TNPostInfoCell.identify, for: indexPath) as! TNPostInfoCell
        cell.selectionStyle = .none
        cell.isPin = pinList.contains(indexPath.row)
        cell.data = FixedData.newFeedData[indexPath.row - 1]
        cell.delegate = self
        cell.viewEmotion.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(holeOpenEmoji)))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row != 0){
            let viewInfo = TNInfoViewController.createInstance(index : indexPath.row - 1)
            viewInfo.refreshDelegate = self
            self.present(viewInfo, animated: true, completion: nil)
            return
        }
    }
}

extension TNNewFeedViewController : TNNewPostDelegate {
    
    @objc func holeOpenEmoji(_ gesture: UIGestureRecognizer){
        let pos = gesture.location(in: self.tablePost)
        if let indexPath = self.tablePost.indexPathForRow(at: pos) {
            let frame = tablePost.rectForRow(at: indexPath)
            let vc = TNPopupChooseEmotionViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self
            vc.origin = CGPoint(x: frame.origin.x + 2, y: gesture.location(in: self.view).y)
            vc.indexPath = indexPath
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    func newPostAvatarTap(_ gesture: UIGestureRecognizer) {
        newPost()
    }
    
    func newPostNewTap(_ gesture: UIGestureRecognizer) {
        newPost()
    }
    
    func newPostPickImageTap(_ gesture: UIGestureRecognizer) {
        btnClicked()
    }
}

extension TNNewFeedViewController : TNPostInfoDelegate {
    func actPostSeenUser(_ gesture: UIGestureRecognizer) {
        let view = TNSeenUserViewController()
        view.modalPresentationStyle = .overCurrentContext
        self.present(view, animated: false, completion: nil)
    }
    
    func actPostComment(_ gesture: UIGestureRecognizer) {
        let pos = gesture.location(in: self.tablePost)
        if let indexPath = self.tablePost.indexPathForRow(at: pos) {
            let view = TNCommentedUserViewController()
            view.modalPresentationStyle = .overCurrentContext
            view.index = indexPath.row - 1
            self.present(view, animated: false, completion: nil)
//            view.data = FixedData.newFeedData[].emotion
        }
    }
    
    func actPostMore(_ gesture: UIGestureRecognizer) {
        let view = TNActionSheetViewController()
        view.modalPresentationStyle = .overCurrentContext
        view.data = [TNActionModel(icon: UIImage(named: "ic_pin") ?? UIImage(), option: "Ghim lên đàu trang", description: nil),
                     TNActionModel(icon: UIImage(named: "Post Edit") ?? UIImage(), option: "Chỉnh sửa bài viết", description: nil),
                     TNActionModel(icon: UIImage(named: "Post Copy") ?? UIImage(), option: "Copy đường dẫn", description: nil),
                     TNActionModel(icon: UIImage(named: "Post Delete") ?? UIImage(), option: "Xoá bài viết", description: nil)]
        view.customFont = Constant.text.font.normal
        self.present(view, animated: false, completion: nil)
        
    }
    
    func actPostImageView(_ gesture: UIGestureRecognizer) {
        let pos = gesture.location(in: self.tablePost)
        if let indexPath = self.tablePost.indexPathForRow(at: pos) {
            let view = TNLibraryImageViewController()
            view.modalPresentationStyle = .overCurrentContext
            self.present(view, animated: false, completion: nil)
            view.data = FixedData.newFeedData[indexPath.row - 1].image
        }
    }
    
    func actPostPin(_ gesture: UIGestureRecognizer) {
        let pos = gesture.location(in: self.tablePost)
        if let indexPath = self.tablePost.indexPathForRow(at: pos) {
            var target = -1
            for index in 0..<pinList.count {
                if (pinList[index] == indexPath.row) {
                    target = index
                    break
                }
            }
            if (target == -1) {
                pinList.append(indexPath.row)
            } else {
                pinList.remove(at: target)
            }
            tablePost.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func actPostEmoji(_ gesture: UIGestureRecognizer) {
        let pos = gesture.location(in: self.tablePost)
        if let indexPath = self.tablePost.indexPathForRow(at: pos) {
            let view = TNEmojiListViewController()
            view.modalPresentationStyle = .overCurrentContext
            self.present(view, animated: false, completion: nil)
            view.data = FixedData.newFeedData[indexPath.row - 1].emotion
        }
    }
    
    func actPostEmotion(_ gesture: UIGestureRecognizer) {
        let pos = gesture.location(in: self.tablePost)
        if let indexPath = self.tablePost.indexPathForRow(at: pos) {
            print("Post: \(indexPath.row)")
            var isActed = false
            for index in 0..<FixedData.newFeedData[indexPath.row - 1].emotion.count {
                if (FixedData.newFeedData[indexPath.row - 1].emotion[index].userName == FixedData.user) {
                    FixedData.newFeedData[indexPath.row - 1].emotion.remove(at: index)
                    isActed = true
                    break
                }
            }
            if (!isActed) {
                FixedData.newFeedData[indexPath.row - 1].emotion.append(TNEmotionModel(emote: .like, userName: FixedData.user, userAvatar: FixedData.userAvatar))
            }
            tablePost.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func actPostAvatar(_ gesture: UIGestureRecognizer) {
        print("Pin avatar")
    }
}

extension TNNewFeedViewController : PopupEmojiDelegate {
    func selectPos(_ emoji: TNEmoji, indexPath : IndexPath) {
        var isActed = false
        for index in 0..<FixedData.newFeedData[indexPath.row - 1].emotion.count {
            if (FixedData.newFeedData[indexPath.row - 1].emotion[index].userName == FixedData.user) {
                if (FixedData.newFeedData[indexPath.row - 1].emotion[index].emote == emoji) {
                    isActed = true
                }
                FixedData.newFeedData[indexPath.row - 1].emotion.remove(at: index)
                break
            }
        }
        if (!isActed) {
            FixedData.newFeedData[indexPath.row - 1].emotion.append(TNEmotionModel(emote: emoji, userName: FixedData.user, userAvatar: FixedData.userAvatar))
        }
        tablePost.reloadRows(at: [indexPath], with: .none)
    }
    
}

extension TNNewFeedViewController {
    func setupUI(){
        self.view.backgroundColor = Constant.color.naviBack
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarItem.title = "Bảng tin"
        naviBtnRight = UIButton(frame: .zero)
        naviBtnRight!.setImage(UIImage(named: "ic_notification")?.withRenderingMode(.alwaysTemplate), for: .normal)
        naviBtnRight!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openNotifi)))
        naviLbTitle = UILabel(text: "Bảng tin",
                              textColor: Constant.text.color.black,
                              font: Constant.text.font.customFont(
                                size: Constant.text.size.large + 2,
                                weight: .Bold
        ))
        naviLbTitle?.isUserInteractionEnabled = true
        naviLbTitle?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollNew)))
        self.view.addSubview(tablePost)
        setNavigation(image: UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate), leftAction: nil)
        navigation.dropShadow()
        
        self.view.addSubview(UIView()) { (noti) -> (Void) in
            noti.snp.makeConstraints({ (maker) in
                maker.width.equalTo(noti.snp.height)
                maker.width.equalTo(12)
                maker.bottom.equalTo(self.naviBtnLeft.snp.top).offset(Constant.size.btnIcon * 3 / 4 + 8)
                maker.trailing.equalTo(self.naviBtnLeft.snp.leading).offset(Constant.size.btnIcon * 3 / 4 + 8)
            })
            noti.backgroundColor = UIColor(255,138,101)
            noti.layer.cornerRadius = 6
            noti.clipsToBounds = true
            noti.layer.borderWidth = 2
            noti.layer.borderColor = UIColor.white.cgColor
        }
        
        naviConstraint = navigation.heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
        naviConstraint.isActive = true
        
        tablePost.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(navigation.snp.bottom)
        }
        tablePost.delegate = self
        tablePost.dataSource = self
        tablePost.separatorStyle = .none
        tablePost.bounces = false
        tablePost.register(TNPostInfoCell.self, forCellReuseIdentifier: TNPostInfoCell.identify)
        tablePost.register(TNNewPostCell.self, forCellReuseIdentifier: TNNewPostCell.identify)
    }
}
