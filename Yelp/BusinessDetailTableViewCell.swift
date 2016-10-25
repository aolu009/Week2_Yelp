//
//  BusinessDetailTableViewself.swift
//  Yelp
//
//  Created by Lu Ao on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var pricing: UILabel!
    @IBOutlet weak var numberOfReview: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var categories: UILabel!
    
    var business : Business?{
        didSet{
            self.name.text = business?.name!
            self.poster.setImageWith((business?.imageURL)!)
            self.ratingImage.setImageWith((business?.ratingImageURL)!)
            self.Address.text = business?.address
            self.categories.text = business?.categories
            self.distance.text = business?.distance
            self.numberOfReview.text = String(describing: Int((business?.reviewCount!)!)) + " Reviews"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.poster.layer.cornerRadius = 3
        self.poster.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
