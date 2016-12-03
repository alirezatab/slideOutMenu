//
//  ContainerMainViewView.swift
//  SlideOutMenu
//
//  Created by ALIREZA TABRIZI on 12/3/16.
//  Copyright © 2016 AR-T.com, Inc. All rights reserved.
//

/// The ContainerMainView is the main class that will manage everything and all the sub views

import UIKit

//side menu status variable
enum SideMenuState{
    case closed
    case opened
}

class ContainerMainView: UIViewController, SideMenuDelegate {

    // Variable Definition
    var centerNavagationController: UINavigationController!
    var centerViewController: MainView!
    
    var sideMenuState: SideMenuState = .closed{
        didSet{
            let showShadow = sideMenuState != .closed
            showShadowForCenterViewController(shouldShowShadow: showShadow)
        }
    }
    
    var sideMenuController: SideMenuController?
    let sideMenuWidth: CGFloat = 150 //define here the side menu width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainView") as? MainView
        
        SideMenuDelegate = self
        
        centerNavagationController = UINavigationController(rootViewController: centerNavagationController)
        view.addSubview(centerNavagationController)
        
        centerNavagationController.didMove(toParentViewController: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerMainView.handlePanGesture(_:)))
        centerNavagationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func tooglePanel() {
        let notAlreadyExpanded = (sideMenuState != .opened)
        if notAlreadyExpanded{
            addPanelViewController()
        }
        animateRightPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
        switch (sideMenuState){
        case .opened:
            tooglePanel()
        default:
            break
        }
    }
    
    func addPanelViewController() {
        if sideMenuController == nil {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            sideMenuController = mainStoryBoard.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuController
            
            addChildSidePanelController(menu: sideMenuController!)
        }
    }
    
    func addChildSidePanelController(menu: SideMenuController) {
        view.insertSubview(menu.view, at: 0)
        addChildViewController(menu)
        menu.didMove(toParentViewController: self)
    }
    
    func animateRightPanel(shouldExpand: Bool) {
        if shouldExpand {
            sideMenuState = .opened
            animateCenterPanelXPosition(targetPosition: sideMenuWidth)
        } else {
            animateCenterPanelXPosition(targetPosition: 0, completion: { _ in
                self.sideMenuState = .closed
                
                self.sideMenuController!.view.removeFromSuperview()
                self.sideMenuController = nil
            })
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavagationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavagationController.view.layer.shadowOpacity = 0.8
            centerNavagationController.view.layer.shadowRadius = 20
        } else {
            centerNavagationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func openSideMenu()
    {
        tooglePanel()
    }

    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch(recognizer.state){
        case .began:
            if(sideMenuState == .closed){
                if(gestureIsDraggingFromLeftToRight == false){
                    addPanelViewController()
                }
                showShadowForCenterViewController(shouldShowShadow: true)
            }
            
        case .changed:
            let screen_center = recognizer.view!.frame.width/2
            let new_center = recognizer.view!.center.x+recognizer.translation(in: view).x
            if(screen_center >= new_center)
            {
                recognizer.view!.center.x = new_center
                recognizer.setTranslation(CGPoint.zero, in: view)
            }
            
            
        case .ended:
            if(sideMenuController != nil)
            {
                let rec_center = recognizer.view!.center.x
                let screen_center = recognizer.view!.frame.width/2
                if(abs(screen_center-rec_center) > 20)
                {
                    
                    let direction = ( (recognizer.velocity(in: view).x < 10))
                    animateRightPanel(shouldExpand: direction)
                    
                }
                else
                {
                    let open = abs(screen_center - rec_center) > 40
                    animateRightPanel(shouldExpand: open)
                }
                
            }
            
        default:
            break
        }
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
