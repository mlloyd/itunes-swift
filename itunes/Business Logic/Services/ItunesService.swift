//
//  ItunesService.swift
//  itunes
//
//  Created by Martin Lloyd on 22/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
protocol ItunesServiceProtocol: class {
    
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class ItunesService: ItunesServiceProtocol {
    
    weak var remoteService: ItunesRemoteServiceProtocol?

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    init(remoteService: ItunesRemoteServiceProtocol) {
        self.remoteService = remoteService
    }
}