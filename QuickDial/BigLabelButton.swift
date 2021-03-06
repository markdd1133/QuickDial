//
//  BigLabelButton.swift
//  QuickDial
//
//  Created by Sheng Chi Chen on 2017/4/26.
//  Copyright © 2017年 Sheng Chi Chen. All rights reserved.
//

import UIKit

class BigLabelButton: UIButton {

    let bigLabel = UILabel()
    var colorArray:[UIColor]?
    var colorPressArray:[UIColor]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bigLabel.text = "Long Press"
        bigLabel.textColor = UIColor.white
        bigLabel.shadowColor = UIColor.black
        addSubview(bigLabel)
        
        colorArray = [
            UIColor(red: 0.91, green: 0.26, blue: 0.12, alpha: 1),
            UIColor(red: 0.98, green: 0.66, blue: 0.03, alpha: 1),
            UIColor(red: 0.01, green: 0.63, blue: 0.51, alpha: 1),
            UIColor(red: 0.04, green: 0.67, blue: 0.86, alpha: 1),
            UIColor(red: 0.01, green: 0.5, blue: 0.81, alpha: 1)
        ]
        
        colorPressArray = [
            UIColor(red: 0.79, green: 0.15, blue: 0, alpha: 1),
            UIColor(red: 0.86, green: 0.54, blue: 0, alpha: 1),
            UIColor(red: 0, green: 0.51, blue: 0.4, alpha: 1),
            UIColor(red: 0, green: 0.55, blue: 0.74, alpha: 1),
            UIColor(red: 0, green: 0.38, blue: 0.7, alpha: 1)
        ]
        
        if colorArray != nil{
            backgroundColor = colorArray![tag]
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
            guard colorArray != nil && colorPressArray != nil else{ return }
            switch isHighlighted {
            case true:
                backgroundColor = colorPressArray![tag]
                bigLabel.textColor = UIColor.gray
            case false:
                backgroundColor = colorArray![tag]
                bigLabel.textColor = UIColor.white
            }
        }
    }
}
