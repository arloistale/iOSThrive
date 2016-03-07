//
//  CardCollectionViewController.swift
//  Thrive
//
//  Created by Jonathan Lu on 2/16/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CardCell"

class CardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // FlickrSearch
    private var searches = [Card]()
    private let api = APIController()
    
    private let numColumns = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        
        // dummy query
        /*
        flickr.searchFlickrForTerm("cats dogs", completion: {
            results, error in
            
            if(error != nil) {
                print("Flickr error: \(error)")
            }
            
            if(results != nil) {
                print("Found \(results!.searchResults.count) matching \(results!.searchTerm)")
                
                self.searches.insert(results!, atIndex: 0)
                self.collectionView?.reloadData()
            }
        })*/
        
        api.searchCards(50, completionHandler: {
            (err, results) in
            
            print("Error: \(err)")
            print("Results: ")
            
            if err != nil {
                print("Card fetch failed: \(err)")
            } else {
                guard let cards = results else {
                    print("Invalid cards received from fetch")
                    return
                }
                
                self.searches = cards
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.collectionView?.reloadData()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print(searches.count)
        return searches.count / numColumns
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numColumns
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CardCollectionViewCell
    
        // Configure the cell
        let card = cardForIndexPath(indexPath)
        cell.backgroundColor = UIColor(colorLiteralRed: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        if let message = card.message {
            cell.messageTextView.text = message
        }
        
        //cell.photoImageView.image = cardPhoto.thumbnail
        cell.photoImageView.layer.borderWidth = 1.0
        cell.photoImageView.layer.borderColor = UIColor.grayColor().CGColor
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let card = cardForIndexPath(indexPath);
        
        if var size = card.thumbnail?.size {
            size.width += 10
            size.height += 10
            return size
        }
        
        return CGSize(width: 200, height: 250)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 100, bottom: 20, right: 100)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

    // MARK: Helpers
    
    func cardForIndexPath(indexPath: NSIndexPath) -> Card {
        let search = searches[indexPath.section * numColumns + indexPath.row]
        return search
    }
}

