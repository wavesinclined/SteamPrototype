//
//  HomeCell.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCell: UICollectionViewCell {
    
    lazy var namelabel: UILabel = {
        var label = UILabel()
        label.text = "Name"
        label.font = Fonts.helveticaBold.of(14)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dot: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.flatGreenDark
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var currentPlayersLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helvetica.of(14)
        label.textColor = UIColor.flatGreenDark
        label.text = "0"
        return label
    }()
    
    lazy var avatarView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.flatNavyBlue
        imageView.clipsToBounds = true
        return imageView
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
        layer.cornerRadius = 6
        layer.masksToBounds = true
        //layer.borderWidth = 1
        //layer.borderColor = UIColor.darkGray.cgColor
        backgroundColor = UIColor.white
        
        
        self.contentView.addSubview(namelabel)
        self.contentView.addSubview(avatarView)
        self.contentView.addSubview(dot)
        self.contentView.addSubview(currentPlayersLabel)
    }
    
    func setUpConstraints() {
        
        avatarView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.bounds.height-70)
         }
        
        namelabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(10)
        }
        
        dot.snp.makeConstraints { (make) in
            make.top.equalTo(namelabel.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(10)
            make.size.equalTo(8)
        }
        
        currentPlayersLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dot)
            make.left.equalTo(dot.snp.right).offset(6)
        }
    }
}

extension HomeCell {
    func setData(_ model: GameShortModel) {
        self.namelabel.text = model.name
        
        if let urlString = model.imageUrlString {
            let url = URL(string: urlString)
            self.avatarView.kf.setImage(with: url)
        } else {
            self.avatarView.image = nil
        }
    }
    
    func setPlayers(_ current: String) {
        self.currentPlayersLabel.text = current
    }
}











