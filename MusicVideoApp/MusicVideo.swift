//
//  MusicVideo.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 08/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import Foundation

class Videos {
    var vRank                   =  0
    
    private var _vName:         String
    private var _vImageUrl:     String
    private var _vVideoUrl:     String
    private var _vPrice:        String
    private var _vArtist:       String
    private var _vImid:         String
    private var _vRights:       String
    private var _vGenre:        String
    private var _vLinkToItunes: String
    private var _vReleaseDate:  String
    
    
    var vImageData: NSData?
    
    
    //Getters in swift may be computed values
    var vName: String {
        return _vName
    }

    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
  
    
    init(data: JSONDictionary){
        
        // Video name
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            self._vName = vName
        }else{
            self._vName = ""
        }
        
        // Video image preview
        if let img = data["im:image"] as? JSONArray,
            image = img [2] as? JSONDictionary,
            immage = image["label"] as? String {
            _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }else{
            _vImageUrl = ""
        }
        
        // Link to 30s preview
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
            
        } else{
            _vVideoUrl = ""
        }
        
        // Price in dollars
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
            self._vPrice = vPrice
        }else{
            self._vPrice = ""
        }
        
        // Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        }else{
            self._vArtist = ""
        }
        //Record label
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
            self._vRights = vRights
        }else{
            self._vRights = ""
        }
        //Artist iTunes unique identifier
        if let id = data["id"] as? JSONDictionary,
            attributes = id["attributes"] as? JSONDictionary,
            vImid = attributes["im:id"] as? String {
            self._vImid = vImid
        }else{
            self._vImid = ""
        }
        // Genre
        if let genre = data["category"] as? JSONDictionary,
            attributes = genre["attributes"] as? JSONDictionary,
            vGenre = attributes["term"] as? String {
            self._vGenre = vGenre
        }else{
            self._vGenre = ""
        }
        // Video release date on itunes
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary,
            attributes = releaseDate["attributes"] as? JSONDictionary,
            vReleaseDate = attributes["label"] as? String {
            self._vReleaseDate = vReleaseDate
        }else{
            self._vReleaseDate = ""
        }
        // iTunes video profile
        if let link = data["id"] as? JSONDictionary,
            vLink = link["label"] as? String {
            self._vLinkToItunes = vLink
        }else{
            self._vLinkToItunes = ""
        }
        
    }
}