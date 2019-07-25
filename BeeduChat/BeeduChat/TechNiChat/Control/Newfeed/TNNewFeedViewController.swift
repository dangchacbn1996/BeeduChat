//
//  NewPostViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNNewFeedViewController : TNBaseViewController {
    
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
    
    override func viewDidLoad() {
        setupUI()
    }
    
    @objc func scrollNew(){
        tablePost.setContentOffset(.zero, animated: true)
    }
    
    @objc func openMessenge(){
        let viewInfo = TNChatManagerViewController()
        viewInfo.modalPresentationStyle = .overFullScreen
        self.view.window!.layer.add(Constant.rightToLeftTrans(), forKey: kCATransition)
        self.present(viewInfo, animated: false, completion: nil)
    }
}

extension TNNewFeedViewController : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        naviLastOffset = scrollView.contentOffset.y
        naviLastHeight = naviConstraint.constant
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let distance : CGFloat = naviLastOffset - scrollView.contentOffset.y
        
        var newHeight = naviLastHeight + distance
        print("Scroll----------------")
        print("ScrollHeight: \(naviConstraint.constant)")
        print("ScrollDistance  : \(distance)")
        print("ScrollNewHeight: \(newHeight)")
        if (newHeight > Constant.size.naviHeight) {
            newHeight = Constant.size.naviHeight + UIApplication.shared.statusBarFrame.height
        } else if (newHeight < UIApplication.shared.statusBarFrame.height + 1) {
            newHeight = UIApplication.shared.statusBarFrame.height + 1
        }
        naviConstraint.constant = newHeight
        var alpha = (newHeight - UIApplication.shared.statusBarFrame.height) / Constant.size.naviHeight
        if (alpha < 0) {
            alpha = 0
        }
        if (alpha > 1) {
            alpha = 1
        }
        print("Alpha: \(alpha)")
        navigation.subviews[0].alpha = alpha
        naviSeparate.alpha = 1 - alpha
    }
}

extension TNNewFeedViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FixedData.newFeedData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TNNewPostCell.identify, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TNPostInfoCell.identify, for: indexPath) as! TNPostInfoCell
        cell.selectionStyle = .none
        cell.actAvatar = UITapGestureRecognizer(target: self, action: #selector(avatarTap(_:)))
        cell.actLike = UITapGestureRecognizer(target: self, action: #selector(tapLike(_:)))
        cell.actEmoji = UITapGestureRecognizer(target: self, action: #selector(tapEmoji(_:)))
        cell.data = FixedData.newFeedData[indexPath.row - 1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row != 0){
            let viewInfo = TNPostInfoViewController.createInstance(index : indexPath.row - 1)
            Constant.animationTo(view: self, type: .push)
            self.present(viewInfo, animated: false, completion: nil)
        }
    }
    
    @objc func avatarTap(_ gesture : UITapGestureRecognizer){
        let pos = gesture.location(in: self.tablePost)
        let indexPath = self.tablePost.indexPathForRow(at: pos)
        print("AvatarTap : \(indexPath?.row)")
    }
    
    @objc func tapLike(_ gesture : UITapGestureRecognizer){
        let pos = gesture.location(in: self.tablePost)
        if let indexPath = self.tablePost.indexPathForRow(at: pos) {
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
    
    @objc func tapEmoji(_ gesture : UITapGestureRecognizer) {
        let pos = gesture.location(in: self.tablePost)
        if let indexPath = self.tablePost.indexPathForRow(at: pos) {
            let view = TNSeenUserViewController()
            view.modalPresentationStyle = .overCurrentContext
            self.present(view, animated: true, completion: nil)
            view.data = FixedData.newFeedData[indexPath.row - 1].emotion
        }
    }
}

extension TNNewFeedViewController {
    func setupUI(){
        self.view.backgroundColor = Constant.color.naviBack
        self.navigationController?.navigationBar.isHidden = true
        
        naviBtnRight = UIButton(frame: .zero)
        naviBtnRight!.setImage(UIImage(named: "ic_mess")?.withRenderingMode(.alwaysTemplate), for: .normal)
        naviBtnRight?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openMessenge)))
        naviLbTitle = UILabel(text: "Bảng tin",
                              textColor: Constant.text.color.black,
                              font: Constant.text.font.customFont(
                                size: Constant.text.size.large,
                                weight: .Bold
        ))
        naviLbTitle?.isUserInteractionEnabled = true
        naviLbTitle?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollNew)))
        setNavigation(image: UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate), leftAction: nil)
        
        naviConstraint = navigation.heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
        naviConstraint.isActive = true
        naviSeparate.alpha = 0
        
        self.view.addSubview(tablePost)
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
