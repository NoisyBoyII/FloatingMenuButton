//
//  ViewController.swift
//  Sample
//
//  Created by Pratap Singh on 29/08/19.
//  Copyright © 2019 Pratap Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    var floatingMenu: FloatingMenuBtn?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        floatingMenu = FloatingMenuBtn(parentView: view, mainButton: menuButton, images: [UIImage(named: "icon_upload")!, UIImage(named: "icon_media")!,UIImage(named: "icon_archive")!])
    }

    @IBAction func menuClicked(_ sender: Any) {
        floatingMenu?.toggleMenu()
    }
    
}

