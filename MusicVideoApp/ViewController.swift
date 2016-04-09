//
//  ViewController.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 08/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: kReachabilityChangedNotification , object: nil)
        
        
        reachabilityStatusChanged()
        
        
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
    func didLoadData(videos: [Videos]){
        print(reachabilityStatus)
        for video in videos {
            print("Videos in Top Ten \(video.vName)")
        }
    }
    
    func reachabilityStatusChanged(){
        
        switch reachabilityStatus {
            
        case NOACESS:
            view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No internet"
        case WIFI:
            view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with Wi-Fi"
        case WWAN:
            view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachabel with Mobile Data"
        default:return
            
        }
    }
    
    // Remove the observer from the view Controller
    deinit{
     NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachabilityStatusChanged", object: nil)
    }
    

}

