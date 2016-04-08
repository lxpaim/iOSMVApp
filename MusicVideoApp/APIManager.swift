//
//  APIManager.swift
//  MusicVideoApp
//
//  Created by Célio Lisboa on 08/04/16.
//  Copyright © 2016 Célio Lisboa. All rights reserved.
//

import Foundation

class APIManager {
    func loadData(urlString:String ,completion: (result: String)-> Void){
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()

        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url){
            
            (data,response,error) ->Void in
            
            dispatch_async(dispatch_get_main_queue()){
                if error != nil {
                    completion(result: error!.localizedDescription)
                }
                else{
                    completion(result: "NSURLSession sucessful ")
                    print(data)
                }
            }
        }
        task.resume()

     }

}
