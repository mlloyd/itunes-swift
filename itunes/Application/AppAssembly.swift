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
        
        // MARK: - View Controllers
        
        // MasterViewController
        defaultContainer.registerForStoryboard(MasterViewController.self) { r, c in
            c.itunesService = r.resolve(ItunesServiceProtocol.self)
            c.imageService  = r.resolve(ImageServiceProtocol.self)
        }
        
        // DetailViewController
        defaultContainer.registerForStoryboard(DetailViewController.self) { r, c in
            c.imageService = r.resolve(ImageServiceProtocol.self)
        }

        // MARK: - Services
        
        // Image Service
        defaultContainer.register(ImageServiceProtocol.self) {
            _ in ImageService()
        }.inObjectScope(.Container)

        // Image Remote Service
        defaultContainer.register(ItunesRemoteServiceProtocol.self) {
            _ in ItunesRemoteService()
        }.inObjectScope(.Container)

        // Itunes Service
        defaultContainer.register(ItunesServiceProtocol.self) { r in
            ItunesService(remoteService: r.resolve(ItunesRemoteServiceProtocol.self)!)
        }.inObjectScope(.Container)
    }
}