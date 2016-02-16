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
        case Happy
        case Surprised
        case Neutral
        case Confused
        case Sad
        case Angry
        
        static let values = [Happy, Surprised, Neutral, Confused, Sad, Angry]
    }
    
    struct PropertyKey {
        static let dateKey = "date"
        static let messageKey = "message"
        static let photoKey = "photo"
    }
    
    // MARK: Properties
    
    var date: NSDate
    var message: String
    var photo: UIImage?
    
    // MARK: Initialization
    
    init?(message: String, photo: UIImage?) {
        self.date = NSDate()
        self.message = message
        self.photo = photo
        
        super.init()
        
        if message.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding Implementations
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(message, forKey: PropertyKey.messageKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let message = aDecoder.decodeObjectForKey(PropertyKey.messageKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        
        self.init(message: message, photo: photo)
    }
}