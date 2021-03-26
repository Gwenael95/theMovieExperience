//
//  WebViewController.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var link = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: self.link)!
        let request =  URLRequest (url: url)
        self.webView.load(request)
        
    }
    

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
