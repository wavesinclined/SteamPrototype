//
//  PlatformsCell.swift
//  SteamPrototype
//
//  Created by alice singh on 05/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit

class PlatformCell: UITableViewCell {
    
    lazy var placeholder: UILabel = {
        var label = UILabel()
        label.font = Fonts.helvetica.of(16)
        label.textColor = UIColor.flatGray
        label.text = "Platforms"
        return label
    }()

    
    lazy var macLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helveticaBold.of(18)
        label.textColor = UIColor.darkGray
        label.text = "Mac"
        label.isHidden = true
        return label
    }()
    
    lazy var windowsLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helveticaBold.of(18)
        label.textColor = UIColor.darkGray
        label.text = "Windows"
        label.isHidden = true
        return label
    }()
    
    lazy var linuxLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helveticaBold.of(18)
        label.textColor = UIColor.darkGray
        label.text = "Linux"
        label.isHidden = true
        return label
    }()
    
    lazy var baseStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [self.macLabel, self.linuxLabel, self.windowsLabel])
        stack.alignment = .firstBaseline
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.contentView.addSubview(placeholder)
        self.contentView.addSubview(baseStack)
    }
    
    func setUpConstraints() {
        placeholder.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
        }
        
        baseStack.snp.makeConstraints { (make) in
            make.top.equalTo(placeholder.snp.bottom).offset(6)
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}

extension PlatformCell {
    func setUpData(_ model: Platforms?) {
        if let model = model  {
            if model.linux == true {
                self.linuxLabel.isHidden = false
            }
            if model.mac == true {
                self.macLabel.isHidden = false
            }
            if model.windows == true {
                self.windowsLabel.isHidden = false
            }
        }
    } 
}


