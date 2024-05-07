//
//  LocationService.swift
//  GeofencingApp
//
//  Created by Khadija Asim on 05/05/2024.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    weak var locationServiceDelegate: LocationPermissionDelegate?
    weak var geofenceDelegate: GeofenceDelegate?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
}

// MARK: - Location Permission
extension LocationService {
    
    func requestLocationPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func getLocationPermissionStatus() -> LocationPermissionStatus {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print(LocationPermissionStatus.authorized.message)
            return LocationPermissionStatus.authorized
        case .denied:
            print(LocationPermissionStatus.denied.message)
            return LocationPermissionStatus.denied
        case .restricted:
            print(LocationPermissionStatus.restricted.message)
            return LocationPermissionStatus.restricted
        case .notDetermined:
            print(LocationPermissionStatus.notDetermined.message)
            return LocationPermissionStatus.notDetermined
        @unknown default:
            print(LocationPermissionStatus.notDetermined.message)
            return LocationPermissionStatus.notDetermined
        }
    }
}

// MARK: - Geofence
extension LocationService {
    
    func startMonitoringGeofence(geofence: Geofence, geofenceId: String) {
        let region = CLCircularRegion(center: geofence.center, radius: geofence.radius, identifier: geofenceId)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoring(for: region)
    }
    
    func stopMonitoringGeofence() {
        locationManager.monitoredRegions.forEach {
            locationManager.stopMonitoring(for: $0)
        }
    }
}

// MARK: - Location Manager Delegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Did change Authorization \(status)")
        locationServiceDelegate?.didUpdateLocationPermissionStatus(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Did start monitoring \(region)")
        geofenceDelegate?.didStartMontitoring(region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter geofence \(region)")
        geofenceDelegate?.didEnterGeofence(Date())
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Did exit geofence \(region)")
        geofenceDelegate?.didExitGeofence(Date())
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did fail with error \(error)")
    }
}
