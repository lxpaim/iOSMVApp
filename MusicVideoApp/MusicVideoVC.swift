//
//  MusicVideoVC.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 10/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class MusicVideoVC: UIViewController {

    var videos: Videos!
    
    var securitySwitch:Bool = false
    
    @IBOutlet weak var musicVideoName: UILabel!
    
    @IBOutlet weak var musicVideoGenre: UILabel!
    
    
    @IBOutlet weak var musicVideoPrice: UILabel!
    
    
    @IBOutlet weak var musicVideoRighs: UILabel!
    
    @IBOutlet weak var musicVideoImage: UIImageView!
    
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        switch securitySwitch {
        case true:
            touchIdCheck()
        default:
             shareMedia()
        }
        
       
        
    }
    func touchIdCheck()->Bool{
        // Create an alert 
        let alert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .Cancel, handler: nil))
            
        //Create local auth context 
        let context = LAContext()
        var touchIDError: NSError?
        let reasonString = "Touch is required to share data on network"
        
        // check if local auth is avaliable
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
            // check device response
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (sucess, policyError) -> Void in
                if sucess {
                    dispatch_async(dispatch_get_main_queue(), {[unowned self] in self.shareMedia()})
                }else{
                    alert.title = "Unsucessful"
                    
                    switch LAError(rawValue: policyError!.code)!{
                    case .AppCancel:
                        alert.message = "Authtentication was cancelled by application"
                    case .AuthenticationFailed:
                        alert.message = "User failed to provide valid credentials"
                    case .PasscodeNotSet:
                        alert.message = "Passcode is not set on device"
                    case .SystemCancel:
                        alert.message = "Application was cancelled by the system"
                    case .TouchIDLockout:
                        alert.message = "Too many failed atempts"
                    case .TouchIDNotAvailable:
                        alert.message = "Device does not support touch id"
                    case .UserCancel:
                        alert.message = "User cancelled"
                    case .UserFallback:
                        alert.message = "Passcode not accepted must use touch ID"
                    default:
                        alert.message = "Unable to authenticate"
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        [unowned self] in self.presentViewController(alert, animated: true, completion: nil)
                        })

                }
            })
        }else {
            
            alert.title = "Error"
            
            switch LAError(rawValue: touchIDError!.code)!{
    
            case .TouchIDNotEnrolled:
                alert.message = "TouchID not enrolled"
            case .TouchIDNotAvailable:
                alert.message = "Device does not support touch id"
            case .UserCancel:
                alert.message = "User cancelled"
            case .UserFallback:
                alert.message = "Passcode not accepted must use touch ID"
            case .InvalidContext:
                alert.message = "Context is invalid"
            case .PasscodeNotSet:
                alert.message = "Passcode not set"
            default:
                alert.message = "Local authentication is not avaliable"
            }
            dispatch_async(dispatch_get_main_queue(), {
                [unowned self] in self.presentViewController(alert, animated: true, completion: nil)
                })

        }
        return false
    }
    
    func shareMedia(){
        let activity1 = "Have you had the opportnity to see this video?"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it tell me what you think?"
        let activity4 = videos.vLinkiTunes
        let activity5 = "(Shared with Music Video App - Try it)"
        
        let activityController:UIActivityViewController = UIActivityViewController(activityItems: [activity1,activity2,activity3,activity4,activity5], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            (activity,sucess,items, error) in
            if activity == UIActivityTypeMail {
                print("Email selected")
            }
        }
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        let url  = NSURL(string: videos.vVideoUrl)!
        let player =  AVPlayer(URL: url)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) { 
            playerViewController.player?.play()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicVideoName.text = videos.vName
        
        musicVideoPrice.text = videos.vPrice

        musicVideoGenre.text = videos.vGenre

        musicVideoRighs.text = videos.vRights
        
        if videos.vImageData != nil {
            musicVideoImage.image = UIImage(data: videos.vImageData!)
        }else{
            musicVideoImage.image = UIImage(named: "no_image")
        }

       
        // Do any additional setup after loading the view.
    }
    
    

   }
