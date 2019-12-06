//
//  DetailsViewController.swift
//  SKCityFinder
//
//  Created by Syrine Ferjani on 6.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    private var presenter: DetailsPresenter!
    
    static func `init`(with presenter: DetailsPresenter) -> DetailsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.presenter = presenter
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .darkGray
        
        guard let presenter = presenter else { return }
        presenter.attachView(self)
        presenter.show()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let annotation = MKPointAnnotation()
        let cityRadius: CLLocationDistance = 10000
        let cityCoordinate = MKCoordinateRegion(center: location.coordinate,
                                                latitudinalMeters: cityRadius,
                                                longitudinalMeters: cityRadius)
        annotation.coordinate = cityCoordinate.center
        mapView.addAnnotation(annotation)
        mapView.setRegion(cityCoordinate, animated: true)
    }
}


extension DetailsViewController: DetailsView {
    func showDetails(location: Coord) {
        let cityLocation = CLLocation(latitude: location.lat, longitude: location.lon)
        centerMapOnLocation(location: cityLocation)
    }
}

