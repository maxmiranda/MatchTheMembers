//
//  SecondViewController.swift
//  MatchTheMembers
//
//  Created by Max Miranda on 2/8/18.
//  Copyright © 2018 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITabBarControllerDelegate {
    
    var myTabBarVC : MyTabBarController!
    var streakLabel : UILabel!
    var imageCount : Int!
    var choseCount : Int!
    var correctCount : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTabBarVC = tabBarController as! MyTabBarController
        view.backgroundColor = .white
        streakLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        
        var longestLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        longestLabel.text = "Longest Streak:"
        longestLabel.textAlignment = .center
        longestLabel.center = CGPoint(x: view.frame.width/2, y: 100)
        longestLabel.font = UIFont(name: "Helvetica", size: 24)
        view.addSubview(longestLabel)
        
        
        var lastThreeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        lastThreeLabel.text = "Last Three Results:"
        lastThreeLabel.center = CGPoint(x: view.frame.width/2, y: 250)
        lastThreeLabel.textAlignment = .center
        lastThreeLabel.font = UIFont(name: "Helvetica", size: 24)

        view.addSubview(lastThreeLabel)
        
        
        var photoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (view.frame.width)/3, height: 50))
        photoLabel.text = "Photo"
        photoLabel.center = CGPoint(x: 80, y: 300)
        photoLabel.textAlignment = .center
        photoLabel.font = UIFont(name: "Helvetica", size: 18)
        view.addSubview(photoLabel)
        
        var choseLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (view.frame.width)/3, height: 50))
        choseLabel.text = "You Chose"
        choseLabel.center = CGPoint(x: 60 + (view.frame.width)/3, y: 300)
        choseLabel.textAlignment = .center
        choseLabel.font = UIFont(name: "Helvetica", size: 18)

        view.addSubview(choseLabel)

        
        var correctLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (view.frame.width)/3, height: 50))
        correctLabel.text = "It was"
        correctLabel.center = CGPoint(x: 40 + 2*(view.frame.width)/3, y: 300)
        correctLabel.textAlignment = .center
        correctLabel.font = UIFont(name: "Helvetica", size: 18)
        view.addSubview(correctLabel)
    }
    var chosenLabels : [UILabel?]! = []
    var correctLabels : [UILabel?]! = []
    
    override func viewWillAppear(_ animated: Bool) {
        myTabBarVC.pauseTimer()
        for label in chosenLabels {
            if label != nil {
                label!.removeFromSuperview()
            }
        }
        for label in correctLabels {
            if label != nil {
                label!.removeFromSuperview()
            }
        }
        
        imageCount = 0
        choseCount = 0
        correctCount = 0
        
        streakLabel.text = "\(myTabBarVC.longestStreak!)"
        streakLabel.center = CGPoint(x: view.frame.width/2, y: 170)
        streakLabel.textAlignment = .center
        streakLabel.font = UIFont.systemFont(ofSize: 60)
        view.addSubview(streakLabel)
        
        imageToView(myTabBarVC.lastImage)
        imageToView(myTabBarVC.secondToLastImage)
        imageToView(myTabBarVC.thirdToLastImage)
        
        let chosen = [myTabBarVC.lastChosen, myTabBarVC.secondToLastChosen, myTabBarVC.thirdToLastChosen]
        
        chosenLabels = []
        for chose in chosen {
            chosenLabels.append(choseToView(chose))
        }
        
        let correct = [myTabBarVC.lastCorrect, myTabBarVC.secondToLastCorrect, myTabBarVC.thirdToLastCorrect]
        
        correctLabels = []
        for corr in correct {
            correctLabels.append(correctToView(corr))
        }
    }
    
    func imageToView(_ image: UIImage?) {
        if image != nil {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 50, y: 100, width: 80, height: 80)
            imageView.center = CGPoint(x: 80, y: 380 + imageCount * 100)
            view.addSubview(imageView)
        }
        imageCount = imageCount + 1
    }
    
    func choseToView(_ chose: String?) -> UILabel? {
        if chose != nil {
            var choseLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (view.frame.width)/3, height: 70))
            choseLabel.text = chose!
            choseLabel.center = CGPoint(x: Int(60 + (view.frame.width)/3), y: 380 + choseCount * 100)
            choseLabel.textAlignment = .center
            view.addSubview(choseLabel)
            choseCount = choseCount + 1
            return choseLabel
        }
        return nil

    }
    
    func correctToView(_ correct: String?) -> UILabel?{
        if correct != nil {
            var correctLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (view.frame.width)/3, height: 70))
            correctLabel.text = correct!
            correctLabel.center = CGPoint(x: Int(70 + 2*(view.frame.width)/3), y: 380 + correctCount * 100)
            view.addSubview(correctLabel)
            correctCount = correctCount + 1
            return correctLabel
        }
        return nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

