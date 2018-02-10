//
//  FirstViewController.swift
//  MatchTheMembers
//
//  Created by Max Miranda on 2/8/18.
//  Copyright © 2018 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITabBarControllerDelegate {
    let members : [String] = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", "Srujay Korlakunta", "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", "Jeffrey Zhang"]
    var usedMembers : [Int] = []
    var selectedMember : String!
    
    var currentStreak = 0
    
    var myTabBarVC : MyTabBarController!
    
    var seconds = 5
    
    var timerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
    
    var score = 0
    var scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    
    var button1 : UIButton!
    var button2 : UIButton!
    var button3 : UIButton!
    var button4 : UIButton!
    
    var firstTime = true
    
    var stopButton : UIButton!
    var timerWasRunning = false
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 253/255,green: 253/255, blue: 253/255, alpha: 1)

        button1 = UIButton(frame: CGRect(x: 50, y: 400, width: 300, height: 50))
        button2 = UIButton(frame: CGRect(x: 50, y: 465, width: 300, height: 50))
        button3 = UIButton(frame: CGRect(x: 50, y: 530, width: 300, height: 50))
        button4 = UIButton(frame: CGRect(x: 50, y: 595, width: 300, height: 50))

        myTabBarVC = tabBarController as! MyTabBarController
        myTabBarVC.longestStreak = 0

        view.backgroundColor = .white
        reset()
        scoreLabel.font = UIFont(name: "Avenir Next", size: 20)
        scoreLabel.center = CGPoint(x: 90, y: 50)
        scoreLabel.text = "Correct: \(score)"
        self.view.addSubview(scoreLabel)
        timerLabel.center = CGPoint(x: 20 + view.frame.width/2, y: 50)
        timerLabel.font = UIFont(name: "Avenir Next", size: 25)
        timerLabel.text = "\(seconds)"
        self.view.addSubview(timerLabel)
        
        stopButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        stopButton.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        stopButton.layer.cornerRadius = 10
        stopButton.center = CGPoint(x: view.frame.width - 55, y: 50)
        stopButton.setTitle("Stop", for: [])
        stopButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        stopButton.backgroundColor = .blue
        self.view.addSubview(stopButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !firstTime && timerWasRunning {
            runTimer()
        }
    }
    
    func runTimer() {
        if myTabBarVC.gameTimer != nil {
            myTabBarVC.gameTimer.invalidate()
        }
        myTabBarVC.gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(FirstViewController.updateTimer)), userInfo: nil, repeats: true)
        myTabBarVC.timerIsRunning = true
        timerWasRunning = true
        self.view.isUserInteractionEnabled = true
    }
    
    func pauseTimer()  {
        myTabBarVC.gameTimer.invalidate()
        myTabBarVC.timerIsRunning = false
        timerWasRunning = false
        self.view.isUserInteractionEnabled = false
    }
    
    func toggleTimer() {
        if myTabBarVC.timerIsRunning {
            myTabBarVC.gameTimer.invalidate()
            myTabBarVC.timerIsRunning = false
            timerWasRunning = false
            stopButton.setTitle("Start", for: .normal)
        } else {
            runTimer()
            stopButton.setTitle("Stop", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectRandomMember() -> String {
        var selectedMemberIndex : Int = Int(arc4random_uniform(UInt32(members.count)))
        if usedMembers.count == 0 {
            usedMembers.append(selectedMemberIndex)
        } else {
            while usedMembers.index(of: selectedMemberIndex) != nil {
                selectedMemberIndex = Int(arc4random_uniform(UInt32(members.count)))
            }
            usedMembers.append(selectedMemberIndex)
        }
        return members[selectedMemberIndex]
    }
    
    func memberToPhotoName(_ selectedMember: String) -> String {
        let imageName = selectedMember.lowercased(with: nil)
        return String(imageName.filter { !" \n\t\r".contains($0) })
    }
    
    @objc func updateTimer() {
        if seconds == 0 {
            seconds = 5
            currentStreak = 0
            highlightCorrect(sender: nil)
        } else {
            seconds -= 1
        }
        timerLabel.text = "\(seconds)" //This will update the label.
    }
    
    @objc func correctAction(sender: UIButton!) {
        pauseTimer()
        currentStreak += 1
        if myTabBarVC.longestStreak! < currentStreak {
            myTabBarVC.longestStreak = currentStreak
        }
        score += 1
        scoreLabel.text = "\(score)"
        highlightCorrect(sender: sender)
    }
   
    @objc func incorrectAction(sender: UIButton!) {
        pauseTimer()
        currentStreak = 0
        sender.backgroundColor = .red
        highlightCorrect(sender: sender)
    }

    
    func getCorrectMember() -> String {
        return selectedMember
    }
    
    func highlightCorrect(sender: UIButton?) {
        for button in [button1!, button2!, button3!, button4!] {
            if(button.titleLabel!.text == getCorrectMember()) {
                button.backgroundColor = .green
            }
        }
        moveSecondToThird()
        moveLastToSecond()
        if (sender != nil) { //make new firsts
            myTabBarVC.lastChosen = sender!.titleLabel?.text
        } else {
            myTabBarVC.lastChosen = "None"
        }
        myTabBarVC.lastCorrect = selectedMember
        let imageName = memberToPhotoName(selectedMember)
        myTabBarVC.lastImage = UIImage(named: imageName)

        reset()
    }
    
    func moveLastToSecond() {
        if (myTabBarVC.lastChosen != nil) {
            myTabBarVC.secondToLastImage = myTabBarVC.lastImage
            myTabBarVC.secondToLastChosen = myTabBarVC.lastChosen
            myTabBarVC.secondToLastCorrect = myTabBarVC.lastCorrect
        }
    }
    
    func moveSecondToThird() {
        if (myTabBarVC.secondToLastChosen != nil) {
            myTabBarVC.thirdToLastImage = myTabBarVC.secondToLastImage
            myTabBarVC.thirdToLastChosen = myTabBarVC.secondToLastChosen
            myTabBarVC.thirdToLastCorrect = myTabBarVC.secondToLastCorrect
        }
    }
    
    func reset() {
        if myTabBarVC.timerIsRunning {
            pauseTimer()
        }
        seconds = 5
        usedMembers.removeAll()
        perform(#selector(populateAndRun), with: nil, afterDelay: 1.5)
    }
    
    @objc func populateAndRun() {
        populateScreen()
        if firstTime {
            perform(#selector(runTimer), with: nil, afterDelay: 1.5)
            firstTime = false
        } else {
            runTimer()
        }

    }
    func populateScreen() {
        selectedMember = selectRandomMember();
        let imageName = memberToPhotoName(selectedMember)
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        imageView.layer.shadowOpacity = 0.6
        var size = CGSize()
        size.width = 10
        size.height = 14
        imageView.layer.shadowOffset = size
        imageView.frame = CGRect(x: 50, y: 80, width: 300, height: 300)
        view.addSubview(imageView)
        
        var buttons : [UIButton] = [button1, button2, button3, button4]
        for button in buttons {
            button.removeTarget(nil, action: nil, for: .allEvents)
            button.removeFromSuperview()
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(buttons.count)))
        let correctButton = buttons[randomIndex]
        
        correctButton.addTarget(self, action: #selector(correctAction), for: .touchUpInside)
        correctButton.setTitle(selectedMember, for: [])
        
        for button in buttons {
            button.titleLabel?.font = UIFont(name: "Thonburi", size: 24)
            button.backgroundColor = UIColor(red: 248/255,green: 248/255, blue: 248/255, alpha: 1)
            button.layer.borderColor = UIColor(red: 0.01, green: 0.01, blue: 0.01, alpha: 1).cgColor
            button.layer.cornerRadius = 6.0
            button.setTitleColor(.black, for: .normal)
            self.view.addSubview(button)
        }
        buttons.remove(at: randomIndex)
        var incorrectButtons : [UIButton] = buttons
       
        for button in incorrectButtons {
            button.addTarget(self, action: #selector(incorrectAction), for: .touchUpInside)
            button.setTitle(selectRandomMember(), for: [])
        }
        timerLabel.text = "\(seconds)"
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) */
}

