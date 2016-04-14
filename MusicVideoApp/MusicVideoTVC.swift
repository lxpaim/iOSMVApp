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
    
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: kReachabilityChangedNotification , object: nil)
        
        
        reachabilityStatusChanged()
        
    
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
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        
        title = "iTunes Top \(limit) Music Video"
        
        tableView.reloadData()
    }
    
    
    
    func reachabilityStatusChanged(){
        
        switch reachabilityStatus {
            
        case NOACESS:
            //view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue()) {

            let alert = UIAlertController.init(title: "No internet acess ", message: "Please make sure you are connected to internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default){ action -> () in
                print("Cancel")
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive){ action -> () in
                print("Delete")
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .Default){ action -> () in
                print("Ok")
            }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        alert.addAction(okAction)

        self.presentViewController(alert, animated: true, completion: nil)
            }
            
        default:
            //view.backgroundColor = UIColor.greenColor()

            if videos.count > 0 {
                print("Do not refresh API")
            }else{
                runAPI()
            }
            
        }
    }
    
    
    @IBAction func refresh(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        runAPI()
    }
    
    func getAPIVideoCount(){
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil){
            let countValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            limit = countValue
        }
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDate = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
        
    }
    
    func runAPI () {
        
        getAPIVideoCount()
        
        //Call API
        let url = "https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json"
        let apiManager = APIManager()
        apiManager.loadData(url, completion: didLoadData)
    
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

    
    private struct storyboard{
        static let cellReuseIdentifier = "cell"
        static let segueUIdentifier   = "musicVideoDetails"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell

        cell.video = videos[indexPath.row]
                
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == storyboard.segueUIdentifier {
            if let indexpath = tableView.indexPathForSelectedRow {
                let video = videos[indexpath.row]
                let dvc = segue.destinationViewController as! MusicVideoVC
                
                dvc.videos = video
            }
        }
    }
 

}
