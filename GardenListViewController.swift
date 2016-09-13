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
    
    //    let refreshControl: UIRefreshControl = UIRefreshControl()
    var locationManager: CLLocationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    var currertLocatoin: CLLocation?
    var coordinate: CLLocationCoordinate2D?
    var geocoder: CLGeocoder = CLGeocoder()
    //
    //    func handleRefresh(refreshControl: UIRefreshControl) {
    //
    //        GardenDetailController.sharedController.fetchRecords()
    //            self.tableView.reloadData()
    //            refreshControl.endRefreshing()
    //
    //    }
    //
    
    
    // MARK: View Loading Functions
    //
    //    lazy var refreshControl: UIRefreshControl = {
    //        let refreshControl = UIRefreshControl()
    //        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    //
    //        return refreshControl
    //    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        GardenDetailController.sharedController.fetchRecords()
        UserController.sharedController.fetchCurrentUserRecord { (success) in
            if success {
                print("successfully got current user")
            }
        }
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(gardensWereUpdated), name: GardenDetailControllerDidRefreshNotification , object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func gardensWereUpdated(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
            self.addAnnotatoinToMap()
            GardenDetailController.sharedController.fetchRecords()
        })
    }
    
    //    func refresh () {
    //        GardenDetailController.sharedController.fetchRecords { (_) in
    //
    //            self.refreshControl.endRefreshing()
    //            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    //        }
    //        self.tableView.reloadData()
    //    }
    
    
    // MARK: TableView DataSource Functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GardenDetailController.sharedController.gardens.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let item = tableView.dequeueReusableCellWithIdentifier("gardenListCell", forIndexPath: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let garden = GardenDetailController.sharedController.gardens[indexPath.row]
        
        
        item.backgroundImgView.image = garden.backgroundImg
        item.profileImgView.image = garden.profileImg
        item.gardenNameLabel.text = garden.gdName
        // item.locationLabel.text = garden.gdLocation
        
        
        return item
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let garden = GardenDetailController.sharedController.gardens[indexPath.row]
            GardenDetailController.sharedController.deleteRecord(garden)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        }
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
        let allGardens = GardenDetailController.sharedController.gardens
        for garden in allGardens {
            if let locationCoordinate = garden.gdLocation?.coordinate {
                let annotation = GardenAnnotation(coordinate: locationCoordinate, title: garden.gdName, subtitle: garden.gdBio)
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !annotation.isKindOfClass(MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "hand1.png")
        }
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            // performSegueWithIdentifier("toGardenDetail", sender: view)
            if let annotation = view.annotation {
                
                for garden in GardenDetailController.sharedController.gardens {
                    if annotation.coordinate.latitude == garden.gdLocation?.coordinate.latitude {
                        performSegueWithIdentifier("toDetailFromAnnotation", sender: garden)
                    }
                    
                }
                
            }
        }
    }
    
    
    
    let gardens = GardenDetailController.sharedController.gardens
    
    
    
    //        let   sortedGardens = gardens.sort({ $0.0.clLocation.distanceFromLocation(self.currentLocation) < $0.1.clLocation?.distanceFromLocation(self.currentLocation) })
    //
    //
    //        var sortedGardens: [Garden] {
    //            var sortedGardens: [Garden] = []
    //
    //            guard let currentLocation = currentLocation else { return sortedGardens }
    //
    //            sortedGardens = gardens.sort({ $0.0.clLocation?.distanceFromLocation(currentLocation) < $0.1.clLocation?.distanceFromLocation(currentLocation) })
    //
    //            return sortedGardens
    //        }
    //
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 3000, 3000)
        self.mapView!.setRegion(region, animated: true)
    }
    
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toGardenDetail" {
            
            if let detailViewController = segue.destinationViewController as? GardenDetailViewController,
                selectedIndexPath = self.tableView.indexPathForSelectedRow {
                
                let garden = GardenDetailController.sharedController.gardens
                detailViewController.garden = garden[selectedIndexPath.row]
            }
        } else if segue.identifier == "toDetailFromAnnotation"  {
            guard let garden = sender as? Garden else { return }
            let detailVC = segue.destinationViewController as? GardenDetailViewController
            detailVC?.garden = garden
        }
    }
}


