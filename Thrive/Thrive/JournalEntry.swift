//
//  JournalEntry.swift
//  Thrive
//
//  Created by Jonathan Lu on 1/27/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import UIKit

class JournalEntry: NSObject, NSCoding {
    
    // Mark: Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("journalEntries")
    
    // MARK: Types
    
    enum MoodType: String {
        case Happy = "happyEmoticon"
        case Surprised = "surprisedEmoticon"
        case Neutral = "neutralEmoticon"
        case Confused = "confusedEmoticon"
        case Sad = "sadEmoticon"
        case Annoyed = "annoyedEmoticon"
        case What = "whatEmoticon"
        
        static let values = [Happy, Surprised, Neutral, Confused, Sad, Annoyed, What]
        static let colors = [
            UIColor(colorLiteralRed: 0, green: 1, blue: 0, alpha: 1),
            UIColor(colorLiteralRed: 0, green: 1, blue: 1, alpha: 1),
            UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1),
            UIColor(colorLiteralRed: 1, green: 0, blue: 1, alpha: 1),
            UIColor(colorLiteralRed: 0, green: 0, blue: 1, alpha: 1),
            UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 1),
            UIColor(colorLiteralRed: 1, green: 0.5, blue: 0.5, alpha: 1)
        ]
    }
    
    struct PropertyKey {
        static let dateKey = "date"
        static let messageKey = "message"
        static let photoKey = "photo"
        static let moodKey = "mood"
    }
    
    // MARK: Properties
    
    var date: NSDate
    var message: String
    var moodIndex: Int
    var photo: UIImage?
    
    // MARK: Initialization
    
    init?(date: NSDate, message: String, moodIndex: Int, photo: UIImage?) {
        self.date = date
        self.message = message
        self.moodIndex = moodIndex
        self.photo = photo
        
        super.init()
        
        if message.isEmpty || moodIndex < 0 || moodIndex >= MoodType.values.count {
            return nil
        }
    }
    
    // MARK: NSCoding Implementations
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(message, forKey: PropertyKey.messageKey)
        aCoder.encodeInteger(moodIndex, forKey: PropertyKey.moodKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let message = aDecoder.decodeObjectForKey(PropertyKey.messageKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let moodIndex = aDecoder.decodeIntegerForKey(PropertyKey.moodKey);
        
        self.init(date: date, message: message, moodIndex: moodIndex, photo: photo)
    }
    
    // MARK: Getters
    func getDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .ShortStyle
        
        return formatter.stringFromDate(date);
    }
    
    func getMoodImage() -> UIImage {
        return UIImage(named: MoodType.values[moodIndex].rawValue)!;
    }
    
    func getMoodColor() -> UIColor {
        return MoodType.colors[moodIndex];
    }
}