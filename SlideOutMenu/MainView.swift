//
//  MainView.swift
//  SlideOutMenu
//
//  Created by ALIREZA TABRIZI on 12/3/16.
//  Copyright © 2016 AR-T.com, Inc. All rights reserved.
//

/// The MainView defines the center view

///This class implements the SideMenuClick protocol for changing the background as soon as a click event on the side menu occured.

import UIKit

class MainView: UIViewController {

    @IBOutlet var background: UIImageView!
    var current_background: Int = 0
    var b_list : [String] = ["im1.jpg", "im2.jpg"]
    
    
    @IBAction func Open(sender: AnyObject) {
        sideMenuDelegate?.openSideMenu!()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = UIImage(named: b_list[current_background])
        sideMenuClick = self
    }
    
    func request_background_update()
    {
        background.image = UIImage(named: b_list[current_background])
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
