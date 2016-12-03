//
//  SideMenueController.swift
//  SlideOutMenu
//
//  Created by ALIREZA TABRIZI on 12/3/16.
//  Copyright © 2016 AR-T.com, Inc. All rights reserved.
//

/// SideMenuController defines your custom side menu.

import UIKit

class SideMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableview: UITableView!
    
    //array for the menu elements
    var menu = Array<String>()
    var bcolor=UIColor(red:162/255.0,green:172/255.0,blue:180/255.0,alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menu.append("View 1")
        menu.append("View 2")
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = UIColor.clear
        self.view.backgroundColor = bcolor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        
        
        cell.textLabel?.text = menu[indexPath.row]
        cell.backgroundColor = UIColor.clear
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        
        return cell
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
