//
//  AppAssembly.swift
//  itunes
//
//  Created by Martin Lloyd on 22/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import Swinject

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
extension SwinjectStoryboard {
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    class func setup() {
        
        defaultContainer.registerForStoryboard(MasterViewController.self) { r, c in
            c.itunesService = r.resolve(ItunesServiceProtocol.self)
            c.imageService = r.resolve(ImageServiceProtocol.self)
        }

        defaultContainer.register(ImageServiceProtocol.self) { _ in ImageService() }
        defaultContainer.register(ItunesRemoteServiceProtocol.self) { _ in ItunesRemoteService() }
        
        defaultContainer.register(ItunesServiceProtocol.self) { r in
            ItunesService(remoteService: r.resolve(ItunesRemoteServiceProtocol.self)!)
        }
    }
}