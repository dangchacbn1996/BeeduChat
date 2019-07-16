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
    
    override func viewDidLoad() {
        setupUI()
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
        } else if (newHeight < 0){
            newHeight = 0
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
        self.view.subviews[0].alpha = alpha
        //        let distance : CGFloat = naviLastOffset - scrollView.contentOffset.y
        //        print("ScrollChange: \(distance)")
        //        let newHeaderViewHeight: CGFloat = naviConstraint.constant + distance
        //        naviLastOffset = scrollView.contentOffset.y
        //        print("ScrollUpdate: \(naviLastOffset)")
        //        if newHeaderViewHeight > Constant.size.naviHeight {
        //            naviConstraint.constant = Constant.size.naviHeight
        //        } else if newHeaderViewHeight < 0 {
        //            naviConstraint.constant = 0
        //        } else {
        //            naviConstraint.constant = newHeaderViewHeight
        //            scrollView.contentOffset.y = 0 // block scroll view
        //        }
        //
    }
}

extension NewFeedViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewPostCell.identify, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

extension NewFeedViewController {
    func setupUI(){
        self.view.backgroundColor = Constant.color.naviBack
        self.navigationController?.navigationBar.isHidden = true
        PostView.navigationView(parent: self.view, lbTitle: lbTitle, lbSubTitle: lbSubTitle, btnMenu: btnMenu, btnFunction: btnFunction, btnMore: btnMore, actionMenu: nil, actionNotifi: nil, actionMore: nil)
        naviConstraint = self.view.subviews[0].heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
        naviConstraint.isActive = true
        self.view.addSubview(tablePost)
        tablePost.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(self.view.subviews[1].snp.bottom)
        }
        tablePost.delegate = self
        tablePost.dataSource = self
        tablePost.separatorStyle = .none
        tablePost.register(NewPostCell.self, forCellReuseIdentifier: NewPostCell.identify)
    }
}
