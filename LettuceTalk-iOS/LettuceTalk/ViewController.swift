//
//  ViewController.swift
//  LettuceTalk
//
//  Created by Peter on 12/10/17.
//  Copyright © 2017 Peter. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var containerView: UIView! = nil
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        self.webView = WKWebView()
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string:"http://lettucetalk.tech/")
        let req = NSURLRequest(url: url! as URL)
        self.webView!.load(req as URLRequest)
        //var url: NSURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("index.html")
        //webView?.loadFileURL(url, allowingReadAccessToURL: url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
