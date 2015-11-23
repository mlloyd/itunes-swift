//
//  ItunesService.swift
//  itunes
//
//  Created by Martin Lloyd on 22/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import Foundation

typealias SuccessHandler = (searchResult: [Song]) -> Void
typealias ErrorHandler   = (error: NSError) -> Void

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
protocol ItunesServiceProtocol: class {
    func fetchSearch(searchTerm: String, completionHandler: SuccessHandler, errorHandler: ErrorHandler)
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

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func fetchSearch(searchTerm: String, completionHandler: SuccessHandler, errorHandler: ErrorHandler) {
        self.remoteService?.fetchSearch(searchTerm,
            completionHandler: { (searchResult) in
                completionHandler(searchResult: searchResult);
            },
            errorHandler: { (error) in
                
        })
        
    }
}