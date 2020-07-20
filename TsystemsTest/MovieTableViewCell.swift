//
//  MovieTableViewCell.swift
//  TsystemsTest
//
//  Created by Арина Нефёдова on 19.07.2020.
//  Copyright © 2020 Арина Нефёдова. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mDateLabel: UILabel!
    @IBOutlet weak var mOverviewLabel: UILabel!
    
    @IBOutlet weak var mRateLabel: UILabel!
    
    
    @IBOutlet weak var sB: UIButton!
    
    
    override func awakeFromNib() {
          super.awakeFromNib()
        
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          
      }
    
}
