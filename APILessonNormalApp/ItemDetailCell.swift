//
//  ItemDetailCell.swift
//  APILessonNormalApp
//
//  Created by UrataHiroki on 2021/12/01.
//

import UIKit

class ItemDetailCell: UITableViewCell {

    @IBOutlet weak var mediumImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mediumImageView.image = UIImage(named: "")
        itemNameLabel.text = ""
        itemPriceLabel.text = ""
    }
    
}
