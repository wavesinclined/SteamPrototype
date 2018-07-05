//
//  MetacriticScoreCell.swift
//  SteamPrototype
//
//  Created by alice singh on 04/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit

class MetacriticScoreCell: UITableViewCell {
    lazy var placeholderLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helvetica.of(16)
        label.text = "Metacritic Score"
        label.textColor = UIColor.flatGray
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helveticaBold.of(20)
        label.textColor = UIColor.darkGray
        label.text = "90"
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
        self.contentView.addSubview(placeholderLabel)
        self.contentView.addSubview(scoreLabel)
    }
    func setUpConstraints() {
        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(16)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(placeholderLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}

extension MetacriticScoreCell {
    func setData(_ model: GameDataModel) {
        self.scoreLabel.text = String(describing: model.metacritic?.score ?? 0)
    }
    
}
