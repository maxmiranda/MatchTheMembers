//
//  TabBar.swift
//  MatchTheMembers
//
//  Created by Max Miranda on 2/9/18.
//  Copyright © 2018 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    var longestStreak : Int?
    
    var lastImage: UIImage?
    var lastCorrect: String?
    var lastChosen: String?
    
    var secondToLastImage: UIImage?
    var secondToLastCorrect: String?
    var secondToLastChosen: String?
    
    var thirdToLastImage: UIImage?
    var thirdToLastCorrect: String?
    var thirdToLastChosen: String?
    
    var gameTimer : Timer!
    var timerIsRunning = false
    
    override func viewDidLoad() {
        let attrs = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)
        ]
        UITabBarItem.appearance().setTitleTextAttributes(attrs, for: .normal)
        super.viewDidLoad()
        let tabOne = FirstViewController()
        let image1 = UIImage(named: "user")
        tabOne.tabBarItem = UITabBarItem(title: "Game", image: image1, tag: 0)
        let tabTwo = SecondViewController()
        let image2 = UIImage(named: "analytics")
        tabTwo.tabBarItem = UITabBarItem(title: "Stats", image: image2, tag: 1)
        self.viewControllers = [tabOne, tabTwo]
    }
    
    func pauseTimer()  {
        if timerIsRunning {
            gameTimer.invalidate()
            timerIsRunning = false
        }
    }
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 70
        tabFrame.origin.y = self.view.frame.size.height - 70
        self.tabBar.frame = tabFrame
    }
    // called whenever a tab button is tapped
}


