//
//  BaseViewController.swift
//  Marvel Character
//
//  Created by Gonzalo Vizeu on 26/04/2020.
//  Copyright © 2020 Gonzalo Vizeu. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showTableViewLoader(tableView: UITableView){
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    func hideTableViewLoader(tableView: UITableView){
        tableView.tableFooterView?.isHidden = true
    }
    
    func showLoader(){
        
    }
    
    func hideLoader(){
        
    }
    
    func presentError(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    

}
