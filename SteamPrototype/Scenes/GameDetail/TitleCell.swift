//
//  TitleCell.swift
//  SteamPrototype
//
//  Created by alice singh on 05/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {
    lazy var label: UILabel = {
        var label = UILabel()
        label.font = Fonts.helveticaBold.of(22)
        label.textColor = UIColor.darkGray
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setups()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setups() {
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
