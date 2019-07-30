//
//  TNLibraryImageViewController.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/29/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNLibraryImageViewController : TNBaseViewController {
    
    private var btnBack = UIButton()
    var imageView = UIImageView()
    var data : [String] = [] {
        didSet{
            imageView.image = UIImage(named: self.data[0])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension TNLibraryImageViewController {
    func setupUI(){
        self.view.backgroundColor = .black
        
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview()
        }
        imageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(btnBack)
        btnBack.setImage(UIImage(named: "ic_delete"), for: .normal)
        btnBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        btnBack.snp.makeConstraints { (maker) in
            maker.top.left.equalTo(self.view.safeAreaLayoutGuide).offset(Constant.size.paddingView)
            maker.width.equalTo(btnBack.snp.height)
            maker.width.equalTo(36)
        }
    }
}
