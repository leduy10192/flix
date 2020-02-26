//
//  MovieTrailerViewController.swift
//  flixster
//
//  Created by Duy Le on 2/26/20.
//  Copyright © 2020 Duy Le. All rights reserved.
//

import UIKit
import WebKit
class MovieTrailerViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    var movie_id: String = ""
    var movies = [[String:Any]]()
//    var key: String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("url: https://api.themoviedb.org/3/movie/\(movie_id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        //Get Video EndPoint
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try!
                    JSONSerialization.jsonObject(with: data, options: [])
                    as! [String: Any]

                self.movies = dataDictionary["results"] as! [[String : Any]]
                let key = self.movies[0]["key"]! as! String
                
                let myURL = URL(string:"https://www.youtube.com/watch?v=\(key)")
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
//                self.webView.reload()
            }
        }
        // Do any additional setup after loading the view.
        task.resume()

    }
    
}
