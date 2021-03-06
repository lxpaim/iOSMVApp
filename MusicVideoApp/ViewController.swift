//
//  ViewController.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 08/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Call API
        let url = "https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json"
        let apiManager = APIManager()
        apiManager.loadData(url, completion: didLoadData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Methods
    func didLoadData(result:String){
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction (title: "Ok", style: .Default){
            action -> Void in
            
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion:nil)
    }


}

