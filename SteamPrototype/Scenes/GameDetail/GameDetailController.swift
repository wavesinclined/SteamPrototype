//
//  GameDetail.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit
import Agrume

protocol GameDetailControllerDelegate: class {
    //func gameDetailControllerDidLogOut(_ controller: UIViewController)
}

class GameDetailController: UIViewController {
    weak var delegate: GameDetailControllerDelegate?
    var detail: GameDataModel
    
    enum cellType {
        case title
        case screenshot
        case metacritics
        case description
        case publishers
        case platforms
    }
    
    var cells: [cellType] = [.title, .screenshot, .metacritics , .description, .publishers , .platforms]
    
    lazy var tableview: UITableView = {
        var table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.dataSource = self
        //table.delegate = self
        table.separatorInset = .zero
        table.register(TitleCell.self, forCellReuseIdentifier: TitleCell.reuseId)
        table.register(GameDetailScreenShotCell.self, forCellReuseIdentifier: GameDetailScreenShotCell.reuseId)
        table.register(MetacriticScoreCell.self, forCellReuseIdentifier: MetacriticScoreCell.reuseId)
        table.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reuseId)
        table.register(PublishersCell.self, forCellReuseIdentifier: PublishersCell.reuseId)
        table.register(PlatformCell.self, forCellReuseIdentifier: PlatformCell.reuseId)
        table.tableFooterView = UIView()
        return table
    }()

    override func viewDidLoad() {
       super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        setUpNav()
    }
    
    init(model: GameDataModel) {
        self.detail = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpNav() {
//        let bbt = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(handleLogout))
//        self.navigationItem.setRightBarButton(bbt, animated: true)
    }
    
    func setUpViews() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Detail"
        self.view.addSubview(tableview)
    }
    
    func setUpConstraints() {
        tableview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension GameDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.row] {
        case .title:
            let cell = tableview.dequeueReusableCell(withIdentifier: TitleCell.reuseId, for: indexPath) as! TitleCell
            cell.label.text = self.detail.name
            return cell
        case .screenshot:
            let cell = tableview.dequeueReusableCell(withIdentifier: GameDetailScreenShotCell.reuseId, for: indexPath) as! GameDetailScreenShotCell
            cell.backgroundColor = UIColor.flatWhite
            cell.images = (self.detail.screenshots ?? []).flatMap { $0.pathThumbail }
            cell.delegate = self
            return cell
        case .metacritics:
            let cell = tableview.dequeueReusableCell(withIdentifier: MetacriticScoreCell.reuseId, for: indexPath) as! MetacriticScoreCell
            cell.setData(self.detail)
            return cell
        case .description:
            let cell = tableview.dequeueReusableCell(withIdentifier: DescriptionCell.reuseId, for: indexPath) as! DescriptionCell
            cell.setUpData(self.detail)
            return cell
        case .publishers:
            let cell = tableView.dequeueReusableCell(withIdentifier: PublishersCell.reuseId, for: indexPath) as! PublishersCell
            cell.publishers = self.detail.publishers ?? []
            return cell
        case .platforms:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlatformCell.reuseId, for: indexPath) as! PlatformCell
           cell.setUpData(self.detail.platforms)
           return cell
        }
   }
}

extension GameDetailController: GameDetailScreenShotCellDelegate {
    func didSelectOnImage(_ agrume: Agrume) {
        agrume.show(from: self)
    }
}
extension GameDetailController {

}
