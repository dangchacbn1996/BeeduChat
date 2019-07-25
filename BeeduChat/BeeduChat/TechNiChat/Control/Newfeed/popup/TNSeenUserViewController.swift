//
//  TNSeenUserViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/25/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class TNSeenUserViewController : TNBaseViewController {
    
    private var contentView : UIView!
    private var viewContainer : UIView!
    private var scrollView : UIScrollView!
    private var tableSeen : UITableView!
    private var stackType = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .fill, spacing: 2, design: nil)
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
    
    override func viewDidLoad() {
        setupUI()
        tableSeen.dataSource = self
        tableSeen.delegate = self
        tableSeen.tableFooterView = UIView()
        scrollView.delegate = self
        tableSeen.register(TNSeenUserTVC.self, forCellReuseIdentifier: TNSeenUserTVC.identify)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        scrollView.
//    }
    
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
}

extension TNSeenUserViewController : UIScrollViewDelegate {
//    scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentView.subviews[0].alpha = 0.2 + (scrollView.contentOffset.y / (scrollView.contentSize.height / 2))
        if (scrollView.contentOffset.y <= 0) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("Scroll: \(scrollView.contentOffset.y)")
//        if (scrollView.contentOffset.y < scrollView.contentSize.height / 4) {
//            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//        } else if (scrollView.contentOffset.y <= scrollView.contentSize.height / 2) {
//            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height / 2), animated: true)
//        }
    }
//    scrollView
}

extension TNSeenUserViewController : UITableViewDataSource, UITableViewDelegate{
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
            cell.data = data[indexPath.row]
        } else {
            cell.data = listFilter[indexPath.row]
        }
        return cell
    }
}

extension TNSeenUserViewController {
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
            maker.height.equalTo(self.view.snp.height).multipliedBy(2)
        }
        viewContainer = UIView()
        viewContainer.backgroundColor = .white
        contentView.addSubview(UIView()) { (back) -> (Void) in
            back.snp.makeConstraints({ (maker) in
                maker.top.centerX.width.equalToSuperview()
            })
            back.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            back.alpha = 0.2
        }
        contentView.addSubview(viewContainer)
        viewContainer.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview().multipliedBy(0.5)
            maker.top.equalTo(contentView.subviews[0].snp.bottom)
            maker.centerX.width.equalToSuperview()
            maker.bottom.equalToSuperview()
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
        view.addSubview(UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center, spacing: 2, design: nil)) { (stack) -> (Void) in
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
