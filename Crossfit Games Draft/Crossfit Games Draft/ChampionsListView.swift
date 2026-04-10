//
//  ChampionsListView.swift
//  Crossfit Games Draft
//
//  Created by Tracey Bernstein on 4/2/26.
//
import SwiftUI
import Foundation

class ChampionsList: UIViewController {
    let list: [String] = ["Images"]
    var championModels = [ChampionsResponse]() {
        didSet {
            Task {
                @MainActor in
                championsListTable.reloadData()
            }
        }
    }
    let nextButton = UIButton()
    
    private let championsListTable: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Champions List"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(championsListTable)
        championsListTable.delgate = self
        championsListTable.dataSource = self
        getChampions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        championsListTable.frame = view.bounds
    }
    
    private func getChampions() {
        ChampionsAPI.shared.getchampionsReferenceImageId { results in
        for  i in results .prefix(320) {
            self.championModels.append(i)
        }
    }
}
    @objc func goToNextScreen() {
        let nextScreen = ChampionsInformation()
        nextScreen.title = "Crossfit Athletes"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

extension ChampionsList: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // WHERE CELL IS CONFIGURED
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.parentsViewController = self // PASSING SELF TO COLLECTION VIEW TABLEVIEW CELL SO IT CAN TELL CHAMPIONS LIST TO PRESENT VIEW CONTROLLER
        cell.championModels = championModels
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, herightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    internal func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        UIFont .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .red
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section]
    }
}
