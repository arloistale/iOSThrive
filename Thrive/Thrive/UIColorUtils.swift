//
//  UIColorUtils.swift
//  Thrive
//
//  Created by Jonathan Lu on 2/21/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import UIKit

class UIColorUtils {
    static func imageWithColor(color: UIColor, size: CGSize = CGSizeMake(60, 60)) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        return image;
    }
}