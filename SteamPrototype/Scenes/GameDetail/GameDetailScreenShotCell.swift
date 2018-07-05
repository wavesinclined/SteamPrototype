//
//  GameDetailScreenShotCell.swift
//  SteamPrototype
//
//  Created by alice singh on 04/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit
import Agrume

protocol GameDetailScreenShotCellDelegate: class {
    func didSelectOnImage(_ agrume: Agrume)
}

class GameDetailScreenShotCell: UITableViewCell {
    weak var delegate:  GameDetailScreenShotCellDelegate?
    
    static let cellWidth: CGFloat = 280
        //(UIScreen.main.bounds.width - (32 + 32)) / 2.0
    
    var images: [String] = []
    
    
    var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        let w: CGFloat = GameDetailScreenShotCell.cellWidth
        let h: CGFloat = 180 //GameDetailScreenShotCell.cellWidth + 100
        layout.itemSize = CGSize(width: w, height: h)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.showsHorizontalScrollIndicator = true
        collection.register(ScreenShotCell.self, forCellWithReuseIdentifier: ScreenShotCell.reuseId)
        collection.dataSource = self
        collection.delegate = self
        return collection
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
        self.contentView.addSubview(collectionView)
    }
    
    func setUpConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(180)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func showSlides() {
        
    }
}

extension GameDetailScreenShotCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenShotCell.reuseId, for: indexPath) as! ScreenShotCell
        
        cell.setImageUrl(images[indexPath.item])
        
        return cell
    }
}

extension GameDetailScreenShotCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let agrume = Agrume(urls: images.map(stringToUrl).flatMap{$0},
                            startIndex: indexPath.item,
                            background: .blurred(.light))
        
        delegate?.didSelectOnImage(agrume)
    }
    
    fileprivate func stringToUrl(_ strs: String) -> URL? {
        return URL(string: strs)
    }
}
    

