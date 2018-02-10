//
//  StartScreen.swift
//  MatchTheMembers
//
//  Created by Max Miranda on 2/8/18.
//  Copyright © 2018 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 253/255,green: 253/255, blue: 253/255, alpha: 1)
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.center = CGPoint(x: view.frame.width/2, y: 150)
        view.addSubview(imageView)
        
        let paragraphStyle = NSMutableParagraphStyle()
        //line height size
        paragraphStyle.lineSpacing = 25
        let attrString = NSMutableAttributedString(string: "Match \n the Members")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        let matchLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 325, height: 400))
        matchLabel.attributedText = attrString
        matchLabel.textAlignment = .center
        matchLabel.lineBreakMode = .byWordWrapping
        matchLabel.numberOfLines = 3
        matchLabel.center = CGPoint(x: view.frame.width/2, y: 410)
        matchLabel.font = UIFont(name: "Hiragino Sans", size: 50)
        matchLabel.textColor = UIColor(red: 0/255, green: 168/255, blue: 1, alpha: 1)


        view.addSubview(matchLabel)
        
        let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 325, height: 60))
        startButton.center = CGPoint(x: view.frame.width/2, y: 650)
        startButton.layer.cornerRadius = startButton.frame.height/2
        startButton.backgroundColor = .green
        startButton.setTitle("Start", for: [])
        startButton.titleLabel?.font = UIFont(name: "Helvetica", size: 26)
        startButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(startButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAction (sender: UIButton!) {
        self.performSegue(withIdentifier: "start", sender: self)
    }
}
