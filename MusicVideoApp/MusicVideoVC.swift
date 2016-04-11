//
//  MusicVideoVC.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 10/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit

class MusicVideoVC: UIViewController {

    var videos: Videos!
    
    @IBOutlet weak var musicVideoName: UILabel!
    
    @IBOutlet weak var musicVideoGenre: UILabel!
    
    
    @IBOutlet weak var musicVideoPrice: UILabel!
    
    
    @IBOutlet weak var musicVideoRighs: UILabel!
    
    @IBOutlet weak var musicVideoImage: UIImageView!
    
    @IBAction func playVideo(sender: AnyObject) {
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
