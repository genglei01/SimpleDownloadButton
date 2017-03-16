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
        
        self.btnDownload.layer.borderWidth = 1
        self.btnDownload.layer.borderColor = UIColor.blue.cgColor
        self.btnDownload.tapEvent = { sender in
            if sender.status == .downloading {
                self.btnDownload.layer.borderWidth = 0
            }else{
                self.btnDownload.layer.borderWidth = 1
            }
        }
        
        btnImgDownload.setImage(#imageLiteral(resourceName: "download.png"), for: .willDownload)
        btnImgDownload.stopButtonWidth = 20
        btnImgDownload.emptyLineWidth = 2
        btnImgDownload.progress = 0.3
        btnImgDownload.fillLineWidth = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

