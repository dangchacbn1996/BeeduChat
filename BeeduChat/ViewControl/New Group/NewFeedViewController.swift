//
//  NewPostViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class NewFeedViewController : UIViewController {
    
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
    var navigationView : UIView!
    
    override func viewDidLoad() {
        setupUI()
    }
    
    @objc func scrollNew(){
        tablePost.setContentOffset(.zero, animated: true)
    }
    
    @objc func openMessenge(){
        let viewInfo = ChatViewController()
        viewInfo.modalPresentationStyle = .overFullScreen
        self.view.window!.layer.add(Constant.rightToLeftTrans(), forKey: kCATransition)
        self.present(viewInfo, animated: false, completion: nil)
    }
}

extension NewFeedViewController : UIScrollViewDelegate {
    
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
        if (newHeight > Constant.size.naviHeight){
            newHeight = Constant.size.naviHeight
        } else if (newHeight < 1){
            newHeight = 1
        } else {
            //            scrollView.contentOffset.y = 0
        }
        naviConstraint.constant = newHeight
        var alpha = newHeight / Constant.size.naviHeight
        if (alpha < 0) {
            alpha = 0
        }
        if (alpha > 1) {
            alpha = 1
        }
        self.navigationView.subviews[0].alpha = alpha
        self.navigationView.subviews[1].alpha = 1 - alpha
    }
}

extension NewFeedViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewPostCell.identify, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: PostInfoCell.identify, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row != 0){
            let viewInfo = PostInfoViewController()
            viewInfo.modalPresentationStyle = .overFullScreen
//            self.view.window!.layer.add(Constant.rightToLeftTrans(), forKey: kCATransition)
            Constant.animationTo(view: self, type: .push)
            self.present(viewInfo, animated: false, completion: nil)
        }
    }
    
}

extension NewFeedViewController {
    func setupUI(){
        self.view.backgroundColor = Constant.color.naviBack
        self.navigationController?.navigationBar.isHidden = true
        navigationView = PostView.navigationView(lbTitle: lbTitle, lbSubTitle: lbSubTitle, btnMenu: btnMenu, btnFunction: btnFunction, btnMore: btnMore, actionMenu: UITapGestureRecognizer(target: self, action: #selector(scrollNew)), actionNotifi: nil, actionMore: UITapGestureRecognizer(target: self, action: #selector(openMessenge)))
        self.btnMore.setImage(UIImage(named: "ic_mess")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        navigationView.subviews[1].alpha = 0
        naviConstraint = self.view.subviews[0].heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
        naviConstraint.isActive = true
        self.view.addSubview(tablePost)
        tablePost.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(self.view.subviews[0].snp.bottom)
        }
        tablePost.delegate = self
        tablePost.dataSource = self
        tablePost.separatorStyle = .none
        tablePost.register(PostInfoCell.self, forCellReuseIdentifier: PostInfoCell.identify)
        tablePost.register(NewPostCell.self, forCellReuseIdentifier: NewPostCell.identify)
    }
}
