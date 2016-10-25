//
//  FilterTableViewCell.swift
//  Yelp
//
//  Created by Lu Ao on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol FilterTableViewCellDelegate {
    func filterTableViewCell(filterTableViewCell : FilterTableViewCell, switchValueChanged value : Bool)
}

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var filterLabel: UILabel!
    
    var delegate : FilterTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.filterSwitch.addTarget(self, action: #selector(FilterTableViewCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged(){
        print("Selected")
        self.delegate?.filterTableViewCell(filterTableViewCell: self, switchValueChanged: self.filterSwitch.isOn)
    }

}
