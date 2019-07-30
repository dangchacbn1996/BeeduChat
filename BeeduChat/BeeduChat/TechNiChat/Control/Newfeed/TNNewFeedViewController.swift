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
        
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            print("Button capture")
//
//            imagePicker.delegate = self
//            imagePicker.sourceType = .savedPhotosAlbum
//            imagePicker.allowsEditing = false
//
//            present(imagePicker, animated: true, completion: nil)
//        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        print("PickImage")
//        imageView.image = image
    }
}

extension TNNewFeedViewController : TNNewPostViewDelegate {
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
//            cell.setupUI()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TNPostInfoCell.identify, for: indexPath) as! TNPostInfoCell
        cell.selectionStyle = .none
        cell.isPin = pinList.contains(indexPath.row)
        cell.data = FixedData.newFeedData[indexPath.row - 1]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row != 0){
            let viewInfo = TNInfoViewController.createInstance(index : indexPath.row - 1)
            self.present(viewInfo, animated: true, completion: nil)
            return
        }
    }
}

extension TNNewFeedViewController : TNNewPostDelegate {
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
            let view = TNSeenUserViewController()
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

extension TNNewFeedViewController {
    func setupUI(){
        self.view.backgroundColor = Constant.color.naviBack
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarItem.title = "Bảng tin"
        naviBtnRight = UIButton(frame: .zero)
        naviBtnRight!.setImage(UIImage(named: "ic_notification")?.withRenderingMode(.alwaysTemplate), for: .normal)
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
