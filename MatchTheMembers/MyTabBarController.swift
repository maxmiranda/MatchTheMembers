//
//  TabBar.swift
//  MatchTheMembers
//
//  Created by Max Miranda on 2/9/18.
//  Copyright © 2018 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class TabBar: UIViewController, UITabBarDelegate {
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        let story: UIStoryboard =
            UIStoryboard.init(name: "Main",bundle: nil);
        
        let firstViewController:
            FirstViewController = story.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController;
        
        firstViewController.toggleTimer()
    }
}
