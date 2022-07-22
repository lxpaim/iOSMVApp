//
//  MusicVideoTableViewCell.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 10/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
        didSet{
            updateCell()
        }
    
    }

    @IBOutlet weak var musicVideoImage: UIImageView!
    
    @IBOutlet weak var musicVideoRank: UILabel!
    
    @IBOutlet weak var musicVideoTitle: UILabel!

    func updateCell() {
        
        musicVideoTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        musicVideoRank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)

        
        musicVideoTitle.text = video?.vName
        
        musicVideoRank.text = ("\(video!.vRank)")
        
        //musicVideoImage.image = UIImage(named: "no_image")
        
        if video?.vImageData != nil {
            print("Get data from array ")
            musicVideoImage.image = UIImage(data:video!.vImageData!)
            
            
        }else{
            getVideoImage(video!, imageView: musicVideoImage)
            
        }
        
        
    }
    
    func getVideoImage(video: Videos , imageView: UIImageView ){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            let data  = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image : UIImage?
            
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            // Retornar a main queue
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
            }
            
        }
    }

}
