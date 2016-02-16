//
//  MoodControl.swift
//  Thrive
//
//  Created by Jonathan Lu on 2/7/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import UIKit

class MoodControl: UIView {
    
    // MARK: Properties
    
    var selectedMood = 0
    var moodButtons = [UIButton]()
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for _ in JournalEntry.MoodType.values {
            let button = UIButton()
            button.backgroundColor = UIColor.redColor()
            button.addTarget(self, action: "moodButtonPressed:", forControlEvents: .TouchDown)
            moodButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        // adjust buttons to size of container
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in moodButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + 5))
            button.frame = buttonFrame
        }
    }

    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + 5) * JournalEntry.MoodType.values.count
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Actions
    
    func moodButtonPressed(button: UIButton) {
        print("yay")
    }
}
