//
//  TNActionSheetViewController.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

struct TNActionModel {
    var icon : UIImage
    var option : String
    var description : String? = nil
}

class TNActionSheetViewController : TNBaseViewController {
    
    private var contentView : UIView!
    private var viewContainer : UIView!
    private var scrollView : UIScrollView!
    private var tableSeen : UITableView!
    private var stackType = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .fill, spacing: 2, design: nil)
    private var contentPos : [CGFloat] = []
    private var startScrollY : CGFloat = 0
    var customFont : UIFont? = nil
    var data : [TNActionModel] = []
    
    override func viewDidLoad() {
        setupUI()
        tableSeen.dataSource = self
        tableSeen.delegate = self
        tableSeen.tableFooterView = UIView()
        tableSeen.separatorStyle = .singleLine
        tableSeen.isScrollEnabled = false
        tableSeen.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        tableSeen.register(TNActionTVC.self, forCellReuseIdentifier: TNActionTVC.identify)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(self.view.frame.height + CGFloat(data.count) * TNActionTVC.estimateSize)
        }
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalTo(CGFloat(data.count) * TNActionTVC.estimateSize)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.setContentOffset(CGPoint(x: 0, y: (CGFloat(data.count) * TNActionTVC.estimateSize)), animated: true)
    }
    
    @objc func goBack(){
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension TNActionSheetViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let yOffset = scrollView.contentOffset.y
//        let isScrollUp = yOffset > startScrollY
        
        if scrollView == self.scrollView {
//            if yOffset >= contentPos[0] && tableSeen.contentOffset.y <= 0 {
//                scrollView.isScrollEnabled = false
//                tableSeen.isScrollEnabled = true
//            }
//            contentView.subviews[0].alpha = scrollView.contentOffset.y / (scrollView.contentSize.height / contentRatio)
            if (scrollView.contentOffset.y <= 0) {
                self.dismiss(animated: false, completion: nil)
            }
        }
        
//        if scrollView == self.tableSeen {
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

extension TNActionSheetViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goBack()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSeen.dequeueReusableCell(withIdentifier: TNActionTVC.identify, for: indexPath) as! TNActionTVC
        cell.data = data[indexPath.row]
        if (customFont != nil) {
            cell.customFont = customFont!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TNActionTVC.estimateSize
    }
    
}

extension TNActionSheetViewController {
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
            maker.height.equalTo(self.view.frame.height + CGFloat(data.count) * TNActionTVC.estimateSize)
        }
        viewContainer = UIView()
        viewContainer.backgroundColor = .white
        contentView.addSubview(UIView()) { (back) -> (Void) in
            back.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.equalToSuperview()
                maker.height.equalTo(self.view.frame.height)
            })
            back.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            back.isUserInteractionEnabled = true
            back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goBack)))
        }
        contentView.addSubview(viewContainer)
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalTo(CGFloat(data.count) * TNActionTVC.estimateSize)
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
        tableSeen = UITableView()
        self.viewContainer.addSubview(tableSeen)
        tableSeen.snp.makeConstraints { (maker) in
            maker.center.size.equalToSuperview()
        }
    }
}
