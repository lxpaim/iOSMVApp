//
//  SettingsVC.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 13/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit
import MessageUI

class SettingsVC: UITableViewController , MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedbackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var bestImageQualityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBAction func touchIDSec(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecSetting")
        }else{
            defaults.setBool(false, forKey: "SecSetting")
        }
        
    }
    
    
    @IBAction func setQuality(sender: UISwitch) {
        
        
    }

    @IBOutlet weak var APICnt: UILabel!
    
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    
    @IBAction func countValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(sliderCnt.value)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification , object: nil)
        
        // Stop table from being scrollable
        tableView.alwaysBounceVertical = false
        
        let footer = UIView()
    
        tableView.tableFooterView = footer
        
        title = "Settings"
        
        //Fetch values from NSUserDefaults
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil){
            let countValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = ("\(countValue)")
            sliderCnt.value = Float(countValue)
        }else{
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }
        
              
    }
    
    func preferredFontChange() {
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)        

    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposeViewController = configureMail()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            }else{
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
    
    func configureMail()->MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["jamie.maddrox.multiple@gmail.com"])
        mailComposeVC.setSubject("MVA App Feedback")
        mailComposeVC.setMessageBody("Hi Jamie, \n\n I would like to share the following feedback...", isHTML: false)
        
        return mailComposeVC
    
    }
    
    func  mailAlert(){
    let alertVC:UIAlertController = UIAlertController(title: "No account", message: "Device has no configured mail account", preferredStyle: .Alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Default){ action -> Void  in }
    
        alertVC.addAction(okAction)
        self.presentViewController(alertVC, animated: true, completion: nil)

    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail Failed")
        case MFMailComposeResultSaved.rawValue:
            print("Mail Saved")
        default:
            print("Unknown issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

}
