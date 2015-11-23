//
//  MasterViewController.swift
//  itunes
//
//  Created by Martin Lloyd on 21/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import UIKit

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class MasterViewController: UIViewController {

    weak var itunesService: ItunesServiceProtocol?
    weak var imageService:  ImageServiceProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: [Song]?
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("iTunes Search", comment: "")
        
        self.itunesService?.fetchSearch("Feeder",
            completionHandler: { (searchResult) in
                self.dataSource = searchResult
                self.tableView.reloadData()
            },
            errorHandler: { (error) in
                
        })
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
extension MasterViewController: UITableViewDelegate {
    
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
extension MasterViewController: UITableViewDataSource {
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("kSearchCell", forIndexPath: indexPath)
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let song = self.dataSource?[indexPath.row] else { return }
        
        cell.textLabel?.text = song.trackName
        cell.imageView?.contentMode = .ScaleAspectFit
        
        guard let imageURL = song.imageURL else { return }
        self.imageService?.fetchImage(imageURL,
            completionHandler: { (image) in

                cell.imageView?.image = image
                cell.setNeedsLayout()

            }, errorHandler: { (error) in
                print(imageURL)
        })
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let song = self.dataSource?[indexPath.row], imageURL = song.imageURL else { return }
        self.imageService?.cancelImage(imageURL)
    }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
extension MasterViewController: UISearchBarDelegate {
    
}
