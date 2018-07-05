//
//  PublisherNameCell.swift
//  SteamPrototype
//
//  Created by alice singh on 04/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit

class PublisherNameCell: UICollectionViewCell {
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helveticaBold.of(18)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.contentView.addSubview(nameLabel)
    }
    
    func setUpConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(2)
            make.left.right.equalToSuperview().inset(4)
        }
    }
}

extension PublisherNameCell {

}
