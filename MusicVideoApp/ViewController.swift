//
//  ViewController.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 08/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate  = self
        tableView.dataSource = self
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: kReachabilityChangedNotification , object: nil)
        
        
        reachabilityStatusChanged()
        
        
        //Call API
        let url = "https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json"
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
        self.videos = videos
        for video in videos {
            print("Videos in Top Ten \(video.vName)")
        }
        
        tableView.reloadData()
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row+1)") 
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     return 1
    }

}

