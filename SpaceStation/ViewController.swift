//
//  ViewController.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    //Location manger object
    private var clLocationManager: CLLocationManager!
    var currentLocation: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         * Permission from user to access the device location
         * Initialize location manager and set the location to best
         */
        clLocationManager = CLLocationManager()
        clLocationManager.delegate = self
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.requestWhenInUseAuthorization()
    }
    
    /**
      * Method that will be called when user taps on "Start" button
     */
    @IBAction func showPasses(_ sender: Any) {
        //Check if location manager is enabled or not.
        //Else show settings so that user can enable location services
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                showSettings()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                clLocationManager.requestLocation() //Request once
            }
        } else {
            showSettings()
        }
    }
 
    /**
     * In case of location services disabled, an alert is displayed with Settings button, takes to settings to change location services preferences
     */
    func showSettings() {
        let alertController = UIAlertController (title: "", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     * Passing the device's location coordinates to next view
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PASSES" {
            if let destVC = segue.destination as? PassesTableViewController, let usrLocation = currentLocation {
                destVC.userLocation = usrLocation
            }
        }
    }
}

/**
 * Delegate methods to implement after location is updated and to get the location coordinates and check for the failing error
 */
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        currentLocation = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        currentLocation?.description()
        performSegue(withIdentifier: "PASSES", sender: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(message: "Failed to initialize capturing Location")
    }
}
