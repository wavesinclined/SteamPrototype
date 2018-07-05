//
//  OnBoardingController.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import SnapKit

protocol  OnBoardingControllerDelegate: class {
    func OnBoardingControllerDidSuccessfullFacebookLogin(_ controller: UIViewController)
}

class OnBoardingController: UIViewController {
    weak var delegate: OnBoardingControllerDelegate?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return indicator
    }()
    
    lazy var fbLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "fb")
        return imageView
    }()
    
    lazy var fbButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(handleLogin), for: UIControlEvents.touchUpInside)
        button.setTitle("Facebook login", for: .normal)
        button.setTitleColor(Colors.darkGray, for: .normal)
        button.setTitleColor(Colors.lightGrey, for: .highlighted)
        button.titleLabel?.font = Fonts.helveticaBold.of(20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(activityIndicator)
        
        let stack = UIStackView(arrangedSubviews: [fbLogo, fbButton])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .bottom
        
        self.view.addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        fbLogo.snp.makeConstraints { (make) in
            make.size.equalTo(40)
        }
        
    }
    
    func setUpConstraints() {
        
        activityIndicator.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
        }
    }
}

extension OnBoardingController {
    
    @objc func handleLogin() {
        activityIndicator.startAnimating()
        AppAuth.shared
            .facebookLogin(from: self)
            .done {
                self.delegate?.OnBoardingControllerDidSuccessfullFacebookLogin(self)
            }.catch { (error) in
                debugPrint(error)
            }.finally {
                self.activityIndicator.stopAnimating()
            }
    }
}
