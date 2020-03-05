//
//  TableViewCell.swift
//  SwaggerDeneme
//
//  Created by apple on 18.02.2020.
//  Copyright © 2020 cagatay. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
   
    
    @IBOutlet weak var vLabel: UILabel!
    
    @IBOutlet weak var radioView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
