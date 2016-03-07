//
//  JournalTableViewController.swift
//  Thrive
//
//  Created by Jonathan Lu on 1/27/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import UIKit

class JournalTableViewController: UITableViewController {
    
    // MARK: Properties
    
    private var journalEntries = [JournalEntry]()

    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedEntries = loadEntries() {
            journalEntries += savedEntries
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // get number of journal entries
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalEntries.count
    }

    // rendering for a journal entry cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "JournalTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! JournalTableViewCell

        let entry = journalEntries[indexPath.row]
        cell.photoImageView.image = entry.photo
        cell.dateLabel.text = DateUtils.getPrettyLongDate(entry.date)
        let moodImage = entry.getMoodImage().imageWithRenderingMode(.AlwaysTemplate)
        cell.emoticonImageView.image = moodImage
        cell.emoticonImageView.tintColor = entry.getMoodColor()
        if let message = entry.message {
            cell.messageTextView.text = message
        }

        return cell
    }
    
    // MARK: Actions
    
    // callback for when we return from adding or editing an entry
    // saves our modified entries collection to persistent data path
    @IBAction func unwindToJournalEntriesList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? JournalEntryViewController, journalEntry = sourceViewController.journalEntry {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // comes here after edit even when cancelled, 
                // is ok because if cancelled then no changes were made then journal entry not changed
                journalEntries[selectedIndexPath.row] = journalEntry
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                let newIndexPath = NSIndexPath(forRow: journalEntries.count, inSection: 0)
                journalEntries.append(journalEntry)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            saveEntries()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            journalEntries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }*/

    // MARK: - Navigation

    // Determine if we are adding or editing
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let journalDetailViewController = segue.destinationViewController as! JournalEntryViewController
                
            if let selectedJournalEntryCell = sender as? JournalTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedJournalEntryCell)!
                let selectedJournalEntry = journalEntries[indexPath.row]
                journalDetailViewController.journalEntry = selectedJournalEntry
            }
        }
    }
    
    // MARK: NSCoding Implementations
    
    func saveEntries() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(journalEntries, toFile: JournalEntry.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Unsuccessful save of journal entries")
        }
    }
    
    func loadEntries() -> [JournalEntry]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(JournalEntry.ArchiveURL.path!) as? [JournalEntry]
    }
}
