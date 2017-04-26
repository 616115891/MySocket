//
//  ViewController.swift
//  mysocket
//
//  Created by Ye on 4/24/17.
//  Copyright © 2017 Ye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let timer = Timer(timeInterval: 15, repeats: true) { (timer) in
//            JYChatClient.shareClient.login()
//        }
//        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        JYChatClient.shareClient.openNetworkCommunication()
    }

    @IBAction func logOut(_ sender: Any) {
        JYChatClient.shareClient.disConnect()
    }
}

