//
//  ResturantTableViewCell.swift
//  CC Assesment
//
//  Created by Usama Naseer on 22/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import UIKit
import SDWebImage

class ResturantTableViewCell: UITableViewCell {

    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var resturantName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    func updateCell(model: ResturantCellViewModel) {
        resturantName.text = model.name
        location.text = model.location
        rating.text = String(model.rating)
        reviews.text = model.reviews
        picture.sd_setImage(with: URL(string: model.image), placeholderImage: UIImage(named: "placeholder.png"))

        
    }
}
