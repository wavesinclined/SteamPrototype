//
//  DescriptionCell.swift
//  SteamPrototype
//
//  Created by alice singh on 04/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    var placeholder: UILabel = {
        var label = UILabel()
        label.font = Fonts.helvetica.of(16)
        label.text = "Description"
        label.textColor = UIColor.flatGray
        return label
    }()
    
    lazy var descLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helvetica.of(18)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.text = "seduydddfghutrdfhjiresd"
        return label
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
        self.selectionStyle = .none
        self.contentView.addSubview(placeholder)
        self.contentView.addSubview(descLabel)
    }
    
    func setUpConstraints() {
        placeholder.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(16)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(placeholder.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}

extension DescriptionCell {
    func setUpData(_ model: GameDataModel) {
        self.descLabel.text = model.shortDesc
    }
}
