//
//  DetailViewController.swift
//  facts
//
//  Created by Do Xuan Thanh on 5/16/19.
//  Copyright © 2019 monstar-lab. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var link:String?
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print(link)
        var req = URLRequest(url: URL(string: link!)!)
        req.cachePolicy = .returnCacheDataElseLoad
        webView.loadRequest(req)
    }

}
