//
//  WebViewController.swift
//  coursIos2
//
//  Created by GwenaelMarchetti on 23/03/2021.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var webView: WKWebView!
    var linkBrowser = "http://www.google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadWebView(text: self.linkBrowser)
       
        // Do any additional setup after loading the view.
        self.textField.text = self.linkBrowser
       
    }
    
    func reloadWebView(text: String)  {
       
        let url = URL(string: text)!
        let request =  URLRequest (url: url)
        self.webView.load(request)
    }
    

    @IBAction func goAction(_ sender: Any) {
        self.reloadWebView(text: self.textField.text!)
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
