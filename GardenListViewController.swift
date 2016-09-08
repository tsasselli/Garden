//
//  GardenListViewController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/2/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit

class GardenListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var mapHeightConstraint: NSLayoutConstraint!

    
    let refreshControl: UIRefreshControl = UIRefreshControl()
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        GardenDetailController.sharedController.fetchRecords()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     let refreshControl = UIRefreshControl()
        
       self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: Selector(refresh()), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView?.addSubview(refreshControl)
        
        GardenDetailController.sharedController.fetchRecords()
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(gardensWereUpdated), name: GardenDetailControllerDidRefreshNotification , object: nil)
    }
    
    @IBAction func toggleMap(sender: AnyObject) {
        mapHeightConstraint.active = !mapHeightConstraint.active
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [], animations: { 
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func refresh () {
        GardenDetailController.sharedController.fetchRecords { (_) in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
   
    func gardensWereUpdated(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
           self.tableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let item = tableView.dequeueReusableCellWithIdentifier("gardenListCell", forIndexPath: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let garden = GardenDetailController.sharedController.garden[indexPath.row]
        
        
        item.backgroundImgView.image = garden.backgroundImg
        item.profileImgView.image = garden.profileImg
        item.gardenNameLabel.text = garden.gdName
        
        return item
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GardenDetailController.sharedController.garden.count
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toGardenDetail" {
            
            if let detailViewController = segue.destinationViewController as? GardenDetailViewController,
                selectedIndexPath = self.tableView.indexPathForSelectedRow {
                
                let garden = GardenDetailController.sharedController.garden
                detailViewController.garden = garden[selectedIndexPath.row]
            }
        }

    }
    

}
