//
//  TNSeenUserViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/25/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNEmojiListViewController : TNBaseViewController {
    
    private var contentView : UIView!
    private var viewContainer : UIView!
    private var scrollView : UIScrollView!
    private var tableSeen : UITableView!
    private var stackType = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .fill, spacing: 2, design: nil)
    private let contentRatio : CGFloat = 1.8
    private var contentPos : [CGFloat] = []
    private var startScrollY : CGFloat = 0
//    var data = [TNEmotionModel(emote: <#T##TNEmoji#>, userName: <#T##String#>, userAvatar: <#T##String#>)]
    private var listFilter : [TNEmotionModel] = []
    private var filterType : [TNEmoji] = []
    private var filter : TNEmoji? = nil {
        didSet{
            if (filter != nil) {
                listFilter = []
                for item in data {
                    if (item.emote == self.filter) {
                        listFilter.append(item)
                    }
                }
            }
        }
    }
    var data : [TNEmotionModel] = [] {
        didSet{
            stackType.arrangedSubviews.forEach { (sub) in
                sub.removeFromSuperview()
            }
            if (data.count > 0) {
                stackType.addArrangedSubview(btnFilterType(text: "Tất cả", emoji: nil, count: data.count)) { (btn) -> (Void) in
                    btn.tag = -1
                    btn.subviews[1].isHidden = false
                    btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.filterData(_:))))
                }
                for type in [TNEmoji.like, .haha, .cry, .angry, .heart] {
                    var count = 0
                    for item in data {
                        if (item.emote == type) {
                            count += 1
                        }
                    }
                    if (count != 0) {
                        filterType.append(type)
                        stackType.addArrangedSubview(btnFilterType(text: nil, emoji: type, count: count)) { (btn) -> (Void) in
                            btn.tag = self.filterType.count - 1
                            btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.filterData(_:))))
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        setupUI()
        tableSeen.dataSource = self
        tableSeen.delegate = self
        tableSeen.tableFooterView = UIView()
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        tableSeen.register(TNSeenUserTVC.self, forCellReuseIdentifier: TNSeenUserTVC.identify)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentPos = [scrollView.contentSize.height * (contentRatio - 1) / contentRatio,
                      scrollView.contentSize.height * ((contentRatio - 1) / 2) / contentRatio,
                      0]
        print("EndDraging: \(contentPos)")
        print("EndDraging: Top: \(((contentPos[0] + contentPos[1]) / 2))")
        print("EndDraging: Middle: \((contentPos[1]) / 2)")
        scrollView.setContentOffset(CGPoint(x: 0, y: contentPos[1]), animated: true)
    }
    
    @objc func filterData(_ gesture : UIGestureRecognizer) {
        stackType.arrangedSubviews.forEach { (sub) in
            sub.subviews[1].isHidden = true
        }
        if let btn = gesture.view {
            if (btn.tag != -1) {
                filter = filterType[btn.tag]
                stackType.arrangedSubviews[btn.tag + 1].subviews[1].isHidden = false
            } else {
                filter = nil
                stackType.arrangedSubviews[0].subviews[1].isHidden = false
            }
        }
        tableSeen.reloadData()
    }
    
    @objc func goBack(){
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension TNEmojiListViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let isScrollUp = yOffset > startScrollY
        
        if scrollView == self.scrollView {
            if yOffset >= contentPos[0] && tableSeen.contentOffset.y <= 0 {
                scrollView.isScrollEnabled = false
                tableSeen.isScrollEnabled = true
            }
            contentView.subviews[0].alpha = scrollView.contentOffset.y / (scrollView.contentSize.height / contentRatio)
            if (scrollView.contentOffset.y <= 0) {
                self.dismiss(animated: false, completion: nil)
            }
        }

        if scrollView == self.tableSeen {
            print("tableOffset: \(isScrollUp)")
            print("tableOffset: \(yOffset)")
            print("tableOffset:-------------")
            if yOffset <= 0 && isScrollUp == false {
                self.scrollView.isScrollEnabled = true
                self.tableSeen.isScrollEnabled = false
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            startScrollY = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView == self.scrollView) {
            if (scrollView.contentOffset.y > ((contentPos[0] + contentPos[1]) / 2)) {
                scrollView.setContentOffset(CGPoint(x: 0, y: contentPos[0]), animated: true)
            } else if (scrollView.contentOffset.y < (contentPos[1]) / 2){
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else {
                scrollView.setContentOffset(CGPoint(x: 0, y: contentPos[1]), animated: true)
            }
        }
    }
}

extension TNEmojiListViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (filter == nil) {
            print("table: \(data.count)")
            return data.count
        }
        print("table: \(listFilter.count)")
        return listFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("table: cellForRow")
        let cell = tableView.dequeueReusableCell(withIdentifier: TNSeenUserTVC.identify, for: indexPath) as! TNSeenUserTVC
        if (filter == nil) {
            cell.data = TNUserInfoModel(id: "0", name: data[indexPath.row].userName, avatar: data[indexPath.row].userAvatar)
//            cell.data = data[indexPath.row]
        } else {
            cell.data = TNUserInfoModel(id: "0", name: listFilter[indexPath.row].userName, avatar: listFilter[indexPath.row].userAvatar)
//            cell.data = listFilter[indexPath.row]
        }
        return cell
    }
}

extension TNEmojiListViewController {
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
            maker.height.equalTo(self.view.snp.height).multipliedBy(1.8)
        }
        contentView.addSubview(UIView()) { (back) -> (Void) in
            back.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.equalToSuperview()
            })
            back.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            back.alpha = 0
            back.isUserInteractionEnabled = true
            back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goBack)))
        }
        
        viewContainer = UIView()
        viewContainer.backgroundColor = .white
//        viewContainer.clipsToBounds = true
        viewContainer.layer.cornerRadius = 8
        contentView.addSubview(viewContainer)
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview().multipliedBy(0.5)
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
        self.viewContainer.addSubview(stackType)
        stackType.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.height.equalTo(36)
            maker.leading.equalToSuperview().offset(24)
        }
        self.viewContainer.addSubview(UIView()) { (separate) -> (Void) in
            separate.snp.makeConstraints({ (maker) in
                maker.height.equalTo(Constant.size.separatorHeight)
                maker.centerX.width.equalToSuperview()
                maker.top.equalTo(self.stackType.snp.bottom)
            })
        }
        self.viewContainer.addSubview(tableSeen)
        tableSeen.snp.makeConstraints { (maker) in
            maker.top.equalTo(stackType.snp.bottom).offset(1)
            maker.bottom.equalToSuperview()
            maker.centerX.width.equalToSuperview()
        }
    }
    
    func btnFilterType(text : String?, emoji : TNEmoji?, count : Int) -> (UIView) {
        let view = UIView()
        view.snp.makeConstraints { (maker) in
            maker.width.greaterThanOrEqualTo(56)
        }
        view.addSubview(UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: 4, design: nil)) { (stack) -> (Void) in
            stack.snp.makeConstraints({ (maker) in
                maker.center.height.equalToSuperview()
                maker.width.lessThanOrEqualToSuperview()
            })
            if (text != nil) {
                (stack as! UIStackView).addArrangedSubview(UILabel(text: text!, textColor: Constant.text.color.black, font: nil))
            }
            if (emoji != nil) {
                (stack as! UIStackView).addArrangedSubview(UIImageView(image: UIImage(named: emoji!.rawValue)), design: { (ivEmoji) -> (Void) in
                    ivEmoji.snp.makeConstraints({ (maker) in
                        maker.width.height.equalTo(Constant.size.btnIcon)
                    })

                })
            }
            (stack as! UIStackView).addArrangedSubview(UILabel(text: "\(count)", textColor: Constant.text.color.black, font: nil))
        }
        view.addSubview(UIView()) { (indicator) -> (Void) in
            indicator.snp.makeConstraints({ (maker) in
                maker.height.equalTo(2)
                maker.bottom.centerX.width.equalToSuperview()
            })
            indicator.isHidden = true
            indicator.backgroundColor = UIColor.red
        }
        return view
    }
}
