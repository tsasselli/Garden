//
//  GardenListViewController.swift
//  MyGarden
//
//  Created by Travis Sasselli on 9/2/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import UIKit
import MapKit

class GardenListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mapHeightConstraint: NSLayoutConstraint!
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    var locationManager: CLLocationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    var currertLocatoin: CLLocation?
    var coordinate: CLLocationCoordinate2D?
    var geocoder: CLGeocoder = CLGeocoder()
    
    var garden: Garden?
    
  
    // MARK: View Loading Functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        GardenDetailController.sharedController.fetchRecords()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  addAnnotatoinToMap()
        setupMapView()
        
        let refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: Selector(refresh()), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView?.addSubview(refreshControl)
        
        GardenDetailController.sharedController.fetchRecords()
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(gardensWereUpdated), name: GardenDetailControllerDidRefreshNotification , object: nil)
    }
    
    func gardensWereUpdated(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    func refresh () {
        GardenDetailController.sharedController.fetchRecords { (_) in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: TableView DataSource Functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GardenDetailController.sharedController.garden.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let item = tableView.dequeueReusableCellWithIdentifier("gardenListCell", forIndexPath: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let garden = GardenDetailController.sharedController.garden[indexPath.row]
        
                
        item.backgroundImgView.image = garden.backgroundImg
        item.profileImgView.image = garden.profileImg
        item.gardenNameLabel.text = garden.gdName
       // item.locationLabel.text = garden.gdLocation
    
        
        return item
    }
    
    // MARK: Map Kit/Core Location Setup
    
    
    @IBAction func toggleMap(sender: AnyObject) {
        mapHeightConstraint.active = !mapHeightConstraint.active
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func setupMapView () {
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLHeadingFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView?.showsUserLocation = true
        self.mapView.delegate = self
    }
    
    
    
    func addAnnotatoinToMap () {
        
        if let garden = garden {
            

            let gardenAnnotation = GardenAnnotation(coordinate: (garden.gdLocation?.coordinate)!
                , title: "new garden", subtitle: "made a new garden")
            self.mapView.addAnnotation(gardenAnnotation)
            print("\(gardenAnnotation)")
            
        }
    }
//
//            var sortedGardens: [Garden] {
//            var sortedGardens: [Garden] = []
//            let garden = GardenDetailController.sharedController.garden
//            var lat: Double
//            var lng: Double
//            let location = CLLocation(latitude: lat, longitude: lng)
//            var clLocation: CLLocation? {
//                return CLLocation(latitude: lat, longitude: lng)
//            }
//        }
//    
//
//    
//            sortedGardens = garden.sort({ $0.0.clLocation.distanceFromLocation(clLocation) < $0.1.clLocation?.distanceFromLocation(currentLocation) })
//    
//            return sortedGardens
//        }
//    
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 5000, 5000)
        self.mapView!.setRegion(region, animated: true)
    }
    
    
    
    
    // MARK: - Navigation
    
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
