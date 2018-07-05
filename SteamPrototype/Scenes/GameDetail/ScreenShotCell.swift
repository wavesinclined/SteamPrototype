//
//  ScreenShotCell.swift
//  SteamPrototype
//
//  Created by alice singh on 04/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit

class ScreenShotCell: UICollectionViewCell {
    lazy var screenView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setups()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setups() {
        backgroundColor = UIColor.randomFlat
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        contentView.addSubview(screenView)
        screenView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setImageUrl(_ urlString: String?) {
        if let urlString = urlString {
            let url = URL(string: urlString)
            screenView.kf.setImage(with: url)
            return
        }
        
        screenView.image = nil
    }
    
}
