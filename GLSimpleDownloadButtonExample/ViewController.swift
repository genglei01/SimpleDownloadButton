//
//  ViewController.swift
//  GLSimpleDownloadButtonExample
//
//  Created by LeoGeng on 14/03/2017.
//  Copyright © 2017 LeoGeng. All rights reserved.
//

import UIKit
import GLSimpleDownloadButton

class ViewController: UIViewController {
    @IBOutlet weak var btnDownload: GLSimpleDownloadButton!
    @IBOutlet weak var btnImgDownload: GLSimpleDownloadButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnDownload.tapEvent = { sender in
            if sender.status == .willDownload {
                sender.status = .downloading
            } else if sender.status == .downloading {
                sender.status = .downloaded
            }else if sender.status == .downloaded{
                sender.status = .willDownload
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

