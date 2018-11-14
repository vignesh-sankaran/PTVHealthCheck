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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loading = loadingDialog()
        
        self.present(loading, animated: true, completion: nil)
    }
    
    func loadingDialog() -> UIAlertController {
        let loadingDialog = UIAlertController(title: "Loading", message: nil, preferredStyle: .alert)
        let spinner = UIActivityIndicatorView(frame: loadingDialog.view.frame)
        spinner.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingDialog.view.addSubview(spinner)
        spinner.isUserInteractionEnabled = false
        spinner.startAnimating()
        
        return loadingDialog
    }
}
