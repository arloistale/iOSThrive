//
//  JournalEntryViewController.swift
//  Thrive
//
//  Created by Jonathan Lu on 1/24/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import UIKit

class JournalEntryViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Constants
    
    let placeholderText = "Write a message to her..."
    
    // MARK: Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // the journal entry being written
    var journalEntry: JournalEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init views
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.grayColor().CGColor
        
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.borderColor = UIColor.grayColor().CGColor
        
        // TODO: Placeholder functionality here
        
        // init delegates
        messageTextView.delegate = self
        
        // load data
        if let journalEntry = journalEntry {
            navigationItem.title = "Editing Entry"
            imageView.image = journalEntry.photo
            messageTextView.text = journalEntry.message
        }
        
        saveButton.enabled = checkValidEntry()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender === saveButton {
            let message = messageTextView.text ?? ""
            let photo = imageView.image
            
            // passed to table view
            journalEntry = JournalEntry(message: message, photo: photo)
        }
    }
    
    // MARK: Actions
    
    @IBAction func selectImageFromPicker(sender: UITapGestureRecognizer) {
        // first hide keyboard
        messageTextView.resignFirstResponder()
        
        let sourceType = UIImagePickerControllerSourceType.Camera
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            return
        }
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = sourceType
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // MARK: ImagePicker Delegate Methods
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UITextField Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        saveButton.enabled = checkValidEntry()
    }
    
    // Mark: Helpers
   /*
    // converts message text view to placeholder color if text is empty
    func setPlaceholder() {
        if messageTextView.text == "" {
            messageTextView.text =
        }
    }*/
    
    func checkValidEntry() -> Bool {
        let text = messageTextView.text ?? ""
        return !text.isEmpty
    }
}

