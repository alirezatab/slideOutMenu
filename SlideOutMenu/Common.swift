//
//  Common.swift
//  SlideOutMenu
//
//  Created by ALIREZA TABRIZI on 12/3/16.
//  Copyright © 2016 AR-T.com, Inc. All rights reserved.
//

import Foundation

/// A protocol is an interface that allows the classes to comunicate between each other by using the functions and variable defined by the procol itself.

//delegate that require the side menu to open
@objc protocol SideMenuDelegate{
    @objc optional func openSideMenu()
}

//delegate from the side menu click
@objc protocol SideMenuClick{
    var currenBackground: Int{
        get set
    }
    @objc optional func requestBackgroundUpdate()
}

//delegate variables
var sideMenuClick: SideMenuClick?
var sideMenuDelegate: SideMenuDelegate?
