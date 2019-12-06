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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cityPresenter.showDetails(row: indexPath.row)
    }
}

extension CitiesViewController: CityView {
    func reload() {
        tableView.reloadData()
    }
    
    func showDetails(with presenter: DetailsPresenter) {
        if let split = self.splitViewController as? MainSplitViewController {
            let detailViewController = DetailsViewController.init(with: presenter)
            split.showDetailViewController(detailViewController, sender: nil)
        }
    }
}

extension UITableViewCell: CityCell {
    func show(city: CityViewData) {
        textLabel?.text = "\(city.name)"
        detailTextLabel?.text = "Coordinate (\(city.coord.lat), \(city.coord.lon))"
    }
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        cityPresenter.filterCities(with: "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let keyword = searchBar.text else { return }
        cityPresenter.filterCities(with: keyword)
    }
}
