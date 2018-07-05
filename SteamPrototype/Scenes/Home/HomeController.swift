//
//  HomeController.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit
import PromiseKit

protocol HomeControllerDelegate: class {
    func didSelectGameItem(_ controller: UIViewController, model: GameDataModel)
    func homeControllerDidLogOut(_ controller: UIViewController)
}

class HomeController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return indicator
    }()
    
    weak var delegate: HomeControllerDelegate?
    var games: [GameShortModel] = []
    var fullModels: [GameDataModel] = []
    var statModels: [String] = []
    
    let gameIds = ["570", "271590","624090", "359550", "230410", "578080", "582660"]
    
    var timer: Timer = Timer()
    var refreshTime: TimeInterval = 10
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let w: CGFloat = (UIScreen.main.bounds.width - 16*3) / 2.0
        layout.itemSize = CGSize(width: w, height: (w * 1.2))
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        return layout
    }()
        
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collection.backgroundColor = .clear
        collection.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseId)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: refreshTime,
                                     target: self,
                                     selector: #selector(handleRefresh),
                                     userInfo: nil, repeats: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupViews()
        setupContraints()
        setupNav()
        loadData()
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor.flatWhite
        self.navigationItem.title = "Top Games"
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
    }
    
    func setupContraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func setupNav() {
        let logoutBbi = UIBarButtonItem(title: "Logout?", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.setRightBarButton(logoutBbi, animated: true)
    }
}
    
extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath) as! HomeCell
        cell.setData(games[indexPath.item])
        
        if statModels.count == games.count {
            cell.setPlayers(statModels[indexPath.row])
        }
        
        return cell
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = fullModels[indexPath.item]
        delegate?.didSelectGameItem(self, model: game)
    }
}
    
extension HomeController {
    func loadData() {
        
        when(fulfilled: gameIds.map(GameApi.gameGET)).done { (all: [GameDataModel])  in
            self.fullModels = all // save copy
            let shortModels: [GameShortModel] = all.map(self.createShortModel)
            self.games = shortModels
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
            self.getCurrentPlayers()
        }.catch { error in
            print(error)
        }
    }
    
    fileprivate func createShortModel(_ detail: GameDataModel) -> GameShortModel {
        let short = GameShortModel(gameId: String(detail.appId ?? 0),
                                   name: detail.name ?? "game",
                                   imageUrlString: detail.headerImage,
                                   players: nil)
        return short
    }

    func getCurrentPlayers() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        when(fulfilled: gameIds.map(GameApi.currentPlayers)).done { players in
            self.statModels = players
            self.collectionView.reloadData()
        }.catch { error in
             print(error)
        }.finally {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    @objc func handleRefresh() {
        if self.games.count > 0 {
            getCurrentPlayers()
        }
    }
    
    @objc func handleLogout() {
        do {
            try AppAuth.shared.faceBookLogout()
            self.delegate?.homeControllerDidLogOut(self)
        } catch let error {
            debugPrint(error)
        }
    }
}

