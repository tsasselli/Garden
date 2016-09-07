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
    
    override func viewWillAppear(animated: Bool) {
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GardenDetailController.sharedController.fetchRecords()
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(gardensWereUpdated(_:)), name: GardenListControllerDidRefreshNotification , object: nil)
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
       

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
