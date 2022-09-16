//
//  CryptoTableViewCell.swift
//  Ctrypto
//
//  Created by sawpyae on 9/9/22.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    

    @IBOutlet weak var img: UIImageView!

    @IBOutlet weak var currencyshortLbl: UILabel!

    @IBOutlet weak var currencyLbl: UILabel!
    
    @IBOutlet weak var rateFloatLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(data: CurrencyData) {
        img.image = UIImage(named: data.code ?? "")
        currencyshortLbl.text = data.code
        currencyLbl.text = data.currencyname
        rateFloatLbl.text = data.rate
        
    }
    
}
