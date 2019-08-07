//
//  TNNewPostViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/27/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

protocol TNRefreshDelegate {
    func refreshData()
}

class TNNewPostViewController : TNBaseViewController {
    
    var tfNew = UITextField()
    var delegate : TNRefreshDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tfNew.becomeFirstResponder()
    }
    
    @objc func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func newPost(){
        if (tfNew.text == "") {
            self.dismiss(animated: true, completion: nil)
            return
        }
        let dateType = DateFormatter()
        dateType.dateFormat = "hh:mm"
        FixedData.newFeedData.insert(TNPostInfoModel(userId: "123",
                                                     username: FixedData.user,
                                                     eduClass: "12A1",
                                                     timePosted: dateType.string(from: Date()),
                                                     userAvatar: FixedData.userAvatar,
                                                     content: tfNew.text!,
                                                     image: [],
                                                     viewCount: 0,
                                                     emotion: [],
                                                     comment: []),
                                     at: 0)
        delegate.refreshData()
        self.dismiss(animated: true, completion: nil)
    }
}

extension TNNewPostViewController {
    func setupUI(){
        naviBtnRight = UIButton(frame: .zero)
        naviBtnRight?.setImage(UIImage(named: "ic_post_send"), for: .normal)
        naviBtnRight?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newPost)))
        naviLbTitle = UILabel(text: "Bài viết mới",
                              textColor: Constant.text.color.black,
                              font: Constant.text.font.customFont(size: Constant.text.size.large, weight: .Medium))
        setNavigation(image: UIImage(named: "ic_back"), leftAction: UITapGestureRecognizer(target: self, action: #selector(goBack)))
        tfNew.placeholder = "Viết gì đó cho cả lớp"
        tfNew.font = Constant.text.font.normal
        tfNew.textColor = Constant.text.color.black
        view.addSubview(tfNew)
        tfNew.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().offset(-2 * Constant.size.paddingView)
            maker.top.equalTo(view.subviews[0].snp.bottom).offset(Constant.size.paddingView)
        }
    }
}
