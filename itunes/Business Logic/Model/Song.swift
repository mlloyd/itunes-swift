//
//  Song.swift
//  itunes
//
//  Created by Martin Lloyd on 22/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import UIKit
import ObjectMapper

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class Song: Mappable {
    
    var artistName:  String?
    var trackName:   String?
    var imageURL:    NSURL?
    var albumName:   String?
    var price:       NSNumber?
    var releaseDate: NSDate?
    var audioURL:    NSURL?
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    required init?(_ map: Map){
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func mapping(map: Map) {
        self.artistName  <- map["artistName"]
        self.trackName   <- map["trackName"]
        self.imageURL    <- map["artworkUrl100"]
        self.albumName   <- map["collectionName"]
        self.price       <- map["trackPrice"]
        self.releaseDate <- map["releaseDate"]
        self.audioURL    <- map["previewUrl"]
    }
}