//
//  SettingsVC.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 13/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
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
        
        
      
    }
    
    func preferredFontChange() {
        
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)        

    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

}
