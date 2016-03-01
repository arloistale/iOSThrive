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
    
    private var selectedMood = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var moodButtons = [UIButton]()
    
    private var buttonSpacing = 5
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for (index, mood) in JournalEntry.MoodType.values.enumerate() {
            let normalImage = UIImage(named: mood.rawValue)
            let tintedImage = normalImage?.imageWithRenderingMode(.AlwaysTemplate)
            
            let button = UIButton()
            button.setImage(tintedImage, forState: .Normal)
            button.setImage(tintedImage, forState: .Selected)
            button.setImage(tintedImage, forState: [.Highlighted, .Selected])
            button.tintColor = JournalEntry.MoodType.colors[index]
            
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
            buttonFrame.origin.x = CGFloat(index * (buttonSize + buttonSpacing))
            button.frame = buttonFrame
        }
        
        moodButtons[selectedMood].selected = true
    }

    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + 5) * JournalEntry.MoodType.values.count
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Actions
    
    func moodButtonPressed(button: UIButton) {
        // unselect previously selected button
        moodButtons[selectedMood].selected = false
        
        // select new button
        selectedMood = moodButtons.indexOf(button)!
        button.selected = true;
    }
    
    // MARK: Getters
    
    func getSelectedMoodIndex() -> Int {
        return selectedMood
    }
}
