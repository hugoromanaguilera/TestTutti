//
//  DetailRecordHistoryViewController.swift
//  testTutti
//
//  Created by hugo roman on 10/25/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DetailRecordHistoryViewController: UIViewController {
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var eventLabel: UILabel!
    
    @IBOutlet weak var datetimeLabel: UILabel!
    
    @IBOutlet weak var atLabel: UILabel!
    
    var initialLocation = CLLocation()
    var myRecord : RecordCard!
    var session: NSURLSession!
    var appDelegate: AppDelegate!
    
    let regionRadius: CLLocationDistance = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
        eventLabel.text = ""
        datetimeLabel.text = ""
        atLabel.text = ""
    }
    
    override func viewDidAppear(animated: Bool) {
        
        eventLabel.text = myRecord.rcTipoEvento
        datetimeLabel.text = myRecord.rcFecServidor
        let dbLatitud = NSNumberFormatter().numberFromString(myRecord.rcValLatitud)?.doubleValue
        let dbLongitud = NSNumberFormatter().numberFromString(myRecord.rcValLongitud)?.doubleValue
        print (dbLatitud,dbLongitud)
        if (dbLatitud == nil || dbLongitud == nil) {
            return
        }
        
        /* 1. Set the parameters */
            // There are none...
        /* 2. Build the URL */
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + "\(myRecord.rcValLatitud),\(myRecord.rcValLongitud)" + "&sensor=true"
        let url = NSURL(string: urlString)!
        
        /* 3. Configure the request */
        let request = NSURLRequest(URL: url)
            
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
                
        /* GUARD: Was there an error? */
        guard (error == nil) else {
            print("There was an error with your request: \(error)")
            return
        }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? NSHTTPURLResponse {
                    print("Your request returned an invalid response! Status code: \(response.statusCode)!")
                } else if let response = response {
                    print("Your request returned an invalid response! Response: \(response)!")
                } else {
                    print("Your request returned an invalid response!")
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            /* 5. Parse the data */
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            /* GUARD: Did api return an error? */
            guard (parsedResult.objectForKey("status_code") == nil) else {
                print("Google Map Api returned an error. See the status_code and status_message in \(parsedResult)")
                return
            }
            
            /* GUARD: Is the "results" key in parsedResult? */
            guard let results = parsedResult["results"] as? [[String : AnyObject]] else {
                print("Cannot find key 'results' in \(parsedResult)")
                return
            }
            
            /* 6. Use the data! */
            print("\(results)")
            if results.count == 0 {
                print("Google Map Api returned no address.")
                return
            }
            if let myAddress = results[0]["formatted_address"] as? String {
                dispatch_async(dispatch_get_main_queue()) {
                    self.atLabel.text = myAddress
                }
            } else {
                print("Could not create image from \(data)")
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        //MARK: Waiting
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityView.center = self.view.center
        activityView.startAnimating()

        //MARK: Position in map
        let latDelta:CLLocationDegrees = 0.0025
        let longDelta:CLLocationDegrees = 0.0025
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(dbLatitud!, dbLongitud!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan)
        myMap.setRegion(region, animated: true)
        let pinLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(dbLatitud!, dbLongitud!)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "uGO"
        myMap.addAnnotation(objectAnnotation)
        
        self.view.addSubview(activityView)
        activityView.stopAnimating()

    }
    
    override func viewDidDisappear(animated: Bool) {
        //
    }
    
}


