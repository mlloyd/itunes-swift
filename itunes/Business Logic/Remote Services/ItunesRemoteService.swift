//
//  ItunesRemoteService.swift
//  itunes
//
//  Created by Martin Lloyd on 22/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger
import ObjectMapper

/*//////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
- where SEARCHTERMn is a string that the user can enter in a search box, text field or similar (your choice)
that is visible somewhere in the master view. For example entering "Jack Johnson" in the search box would yield
an end point of http://itunes.apple.com/search?term=Jack+Johnson
*///////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
let kItunesRemoteService_Endpoint = "http://itunes.apple.com/search?term="

typealias SuccessRemoteHandler = (searchResult: [Song]) -> Void
typealias ErrorRemoteHandler   = (error: NSError) -> Void

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
protocol ItunesRemoteServiceProtocol: class {
    func fetchSearch(searchTerm: String, completionHandler: SuccessRemoteHandler, errorHandler: ErrorRemoteHandler);
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class ItunesRemoteService: ItunesRemoteServiceProtocol {
    
    var request: Request?
        
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func fetchSearch(searchTerm: String, completionHandler: SuccessRemoteHandler, errorHandler: ErrorRemoteHandler) {
        
        let resourceURL = kItunesRemoteService_Endpoint + searchTerm
        guard let encodedURL = resourceURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) else { return }
        
        log.debug("encodedURL: \(encodedURL)")
        
        self.request?.cancel()
        
        self.request = Alamofire.request(.GET, encodedURL, parameters: nil)
            .validate(statusCode: 200..<300)            
            .responseJSON { response in
                if (response.result.isFailure == true) {
                    let error = response.result.error ?? NSError(domain: "", code: -100, userInfo: nil)
                    
                    log.debug("error: \(error)")
                    errorHandler(error: error)
                }
                else {
                    guard let responseAPI = Mapper<SongSearchAPI>().map(response.result.value),
                        songs = responseAPI.songs else { completionHandler(searchResult: []); return }
                    
                    log.verbose("Response \(responseAPI.songs)")
                    completionHandler(searchResult: songs)
                }
        }
    }
}
