//
//  AboutViewController.swift
//  SKCityFinder
//
//  Created by Syrine Ferjani on 6.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    private var presenter: Presenter!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyAddress: UILabel!
    @IBOutlet weak var companyDescription: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let model: AboutModel = Model() as AboutModel
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        presenter = Presenter(view: self, model: model)
        presenter.loadAboutInfo()
    }
}

extension AboutViewController: AboutView {
    func configure(with aboutInfo: AboutInfoData) {
        companyName.text = aboutInfo.companyName
        companyAddress.text = "\(aboutInfo.companyAddress), \(aboutInfo.postalCode), \(aboutInfo.city)"
        companyDescription.text = aboutInfo.details
    }
    
    func display(error: ModelError) {
        companyName.text = error.localizedDescription
        companyAddress.text = nil
        companyDescription.text = nil
    }
    
    func setActivityIndicator(hidden: Bool) {
        if hidden {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
