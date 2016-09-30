//
//  AddViewController.swift
//  Spirometer
//
//  Created by Hugo Troche on 9/29/16.
//  Copyright © 2016 Hugo Troche. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveVault() {
        var vault:Vault = Vault()
        vault.name = self.nameTextField?.text
        
        var manager:TrueVault = TrueVault.sharedInstance
        
        manager.saveVault(vault,  onCompletion: { (vaults, error) in
            self.back()
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
