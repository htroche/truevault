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
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.refreshControl?.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        refresh();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(vaults == nil) {
            return 0;
        }
        return vaults!.count;
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = vaults![indexPath.row].name
        return cell
    }
    
    
    func handleRefresh(refreshControl: UIRefreshControl) {
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

