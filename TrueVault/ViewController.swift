//
//  ViewController.swift
//  Spirometer
//
//  Created by Hugo Troche on 9/29/16.
//  Copyright © 2016 Hugo Troche. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var vaults:[Vault]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.refreshControl?.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(vaults == nil) {
            return 0;
        }
        return vaults!.count;
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = vaults![(indexPath as NSIndexPath).row].name
        return cell
    }
    
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        refresh();
    }
    
    func refresh() {
        let manager:TrueVault = TrueVault.sharedInstance
        self.refreshControl?.beginRefreshing()
        manager.loadVaults { (v, error) -> Void in
            self.vaults = v
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }


}

