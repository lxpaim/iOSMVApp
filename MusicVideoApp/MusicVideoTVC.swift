//
//  MusicVideoTVC.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 10/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
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
          //  displayLabel.text = "No internet"
        case WIFI:
            view.backgroundColor = UIColor.greenColor()
        //    displayLabel.text = "Reachable with Wi-Fi"
        case WWAN:
            view.backgroundColor = UIColor.yellowColor()
         //   displayLabel.text = "Reachabel with Mobile Data"
        default:return
            
        }
    }
    
    // Remove the observer from the view Controller
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachabilityStatusChanged", object: nil)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row+1)")
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
