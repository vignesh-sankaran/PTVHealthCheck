//
//  ViewController.swift
//  PTVHealthCheck
//
//  Created by Vignesh Sankaran on 13/11/18.
//  Copyright © 2018 Vignesh Sankaran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel()
    var loading: UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onSuccessfulAPIResponse), name: .SuccessfulResponse, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loading = loadingDialog()
        self.present(loading!, animated: true, completion: nil)
    }
    
    // Credit to ylin0x81 and petesalt. Retrieved 14 November 2018 at https://stackoverflow.com/a/27034447/5891072
    func loadingDialog() -> UIAlertController {
        let loadingDialog = UIAlertController(title: "Loading", message: nil, preferredStyle: .alert)
        let spinner = UIActivityIndicatorView(frame: loadingDialog.view.frame)
        spinner.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingDialog.view.addSubview(spinner)
        spinner.isUserInteractionEnabled = false
        spinner.startAnimating()
        
        return loadingDialog
    }
    
    @objc func onSuccessfulAPIResponse() {
        loading!.dismiss(animated: true, completion: nil)
        var yPosition: CGFloat = 100
        
        let clientClockLabel = UILabel(frame: CGRect(x: 75, y: yPosition, width: 200, height: 100))
        clientClockLabel.text = "ClientClock"
        clientClockLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(clientClockLabel)
        
        let clientClockStatusLabel = UILabel(frame: CGRect(x: 220, y: yPosition, width: 100, height: 100))
        clientClockStatusLabel.text = viewModel.clientClock!
        clientClockStatusLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.view.addSubview(clientClockStatusLabel)
        
        yPosition += 20
        
        let securityTokenLabel = UILabel(frame: CGRect(x: 75, y: yPosition, width: 200, height: 100))
        securityTokenLabel.text = "SecurityToken"
        securityTokenLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(securityTokenLabel)
        
        let securityTokenStatusLabel = UILabel(frame: CGRect(x: 220, y: yPosition, width: 100, height: 100))
        securityTokenStatusLabel.text = viewModel.securityToken!
        securityTokenStatusLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.view.addSubview(securityTokenStatusLabel)
        
        yPosition += 20
        
        let memcacheLabel = UILabel(frame: CGRect(x: 75, y: yPosition, width: 200, height: 100))
        memcacheLabel.text = "MemCache"
        memcacheLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(memcacheLabel)
        
        let memcacheStatusLabel = UILabel(frame: CGRect(x: 220, y: yPosition, width: 100, height: 100))
        memcacheStatusLabel.text = viewModel.memcache!
        memcacheStatusLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.view.addSubview(memcacheStatusLabel)
        
        yPosition += 20
        
        let databaseLabel = UILabel(frame: CGRect(x: 75, y: yPosition, width: 200, height: 100))
        databaseLabel.text = "Database"
        databaseLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(databaseLabel)
        
        let databaseStatusLabel = UILabel(frame: CGRect(x: 220, y: yPosition, width: 100, height: 100))
        databaseStatusLabel.text = viewModel.database!
        databaseStatusLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.view.addSubview(databaseStatusLabel)
    }
}
