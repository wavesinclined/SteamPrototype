//
//  PublishersCell.swift
//  SteamPrototype
//
//  Created by alice singh on 04/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit

class PublishersCell: UITableViewCell {
    var publishers: [String] = []
    
    var placeHolderLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.helvetica.of(16)
        label.textColor = UIColor.flatGray
        label.text = "Publishers"
        return label
    }()
    
    var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let w: CGFloat = (UIScreen.main.bounds.width - (32 + 32))/3.0
        layout.estimatedItemSize = CGSize(width: w, height: 36)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.register(PublisherNameCell.self, forCellWithReuseIdentifier: PublisherNameCell.reuseId)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpconstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.backgroundColor = .white
        self.contentView.addSubview(placeHolderLabel)
        self.contentView.addSubview(collectionView)
    }
    
    func setUpconstraints() {
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(16)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(placeHolderLabel.snp.bottom).offset(2)
            make.left.right.equalToSuperview()
            make.height.equalTo(36)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
extension PublishersCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.publishers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PublisherNameCell.reuseId , for: indexPath) as! PublisherNameCell
        cell.nameLabel.text = self.publishers[indexPath.item]
        return cell
    }
}
