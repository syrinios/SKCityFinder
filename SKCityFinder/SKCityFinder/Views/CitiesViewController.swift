//
//  ViewController.swift
//  SKCityFinder
//
//  Created by Syrine Ferjani on 6.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    fileprivate let cityPresenter = CityPresenter(cityService: CityService())

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        cityPresenter.attachView(self)
        cityPresenter.getCities()
    }
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityPresenter.cityCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cityPresenter.configure(cell: cell, row: indexPath.row)
        return cell
    }
}

extension CitiesViewController: CityView {
    func reload() {
        tableView.reloadData()
    }
}

extension UITableViewCell: CityCell {
    func show(city: CityViewData) {
        textLabel?.text = "\(city.name)"
        detailTextLabel?.text = "Coordinate (\(city.coord.lat), \(city.coord.lon))"
    }
}