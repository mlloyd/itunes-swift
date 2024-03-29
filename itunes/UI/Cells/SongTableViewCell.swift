//
//  SongTableViewCell.swift
//  itunes
//
//  Created by Martin Lloyd on 23/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import UIKit

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.songTitle.text   = ""
        self.coverImage.image = nil
        self.coverImage.alpha = 1.0
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
