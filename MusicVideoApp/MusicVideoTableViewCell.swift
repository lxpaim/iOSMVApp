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
        musicVideoTitle.text = video?.vName
        
        musicVideoRank.text = ("\(video!.vRank)")
        
        musicVideoImage.image = UIImage(named: "no_image")
        
        
    }

}
