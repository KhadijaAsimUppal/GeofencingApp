//
//  ViewController.swift
//  GeofencingApp
//
//  Created by Khadija Asim on 05/05/2024.
//

import UIKit
import CoreLocation

class LocationVC: UIViewController {
    
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var dwelltimeLabel: UILabel!
    @IBOutlet weak var geofenceLabel: UILabel!
    
    private let locationVM = LocationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        initClosures()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationVM.handleLocationAuthorization()
    }
    
}

// MARK: - Closures implementation
extension LocationVC {
    
    func initClosures() {
        
        ///show location services disabled alert with a custom 'Open Settings' action
        locationVM.locationServiceDisabled = { [weak self] title, message in
            let openSettingsAction = UIAlertAction(title: K.openSettingsString, style: .cancel) { (_) in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
            self?.showAlert(title: title, message: message, actions: [openSettingsAction])
        }
        
        ///show location services authorized alert
        locationVM.locationServiceAuthorized = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }

        ///update geofenceLabel with the monitored region
        locationVM.geofenceMontitoringStarted = { [weak self] region in
            self?.geofenceLabel.text = "\(region)"
            
        }
        
        ///update dwelltimeLabel
        locationVM.dwellTimeUpdated = { [weak self] dwellTime in
            self?.dwelltimeLabel.text = "\(dwellTime)"
        }
    }
}

// MARK: - Actions
extension LocationVC {
    
    ///start monitioring geofence for the user entered values
    @IBAction func actionStartMonitoringGeofence(_ sender: UIButton) {
        startMonitoringGeofence()
    }
}

// MARK: - Geofence
extension LocationVC {
    
    ///Stops all previously montitored regions and start montitoring a new one with the user entered values for latitude, longitude and radius
    func startMonitoringGeofence() {
        let latitude = latitudeTextField.text
        let longitude = longitudeTextField.text
        let radius = radiusTextField.text
        locationVM.stopMonitoringGeofence()
        locationVM.startMonitoringGeofence(latitude: latitude ?? "", longitude: longitude ?? "", radius: radius ?? "")
    }
}

// MARK: - Helper functions
extension LocationVC {
    
    ///A generic method to show an alert with a default 'OK' action
    func showAlert(title: String, message: String, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { alert.addAction($0) }
        alert.addAction(UIAlertAction(title: K.okString, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
