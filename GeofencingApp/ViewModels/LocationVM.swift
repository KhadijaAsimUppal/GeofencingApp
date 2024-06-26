//
//  LocationVM.swift
//  GeofencingApp
//
//  Created by Khadija Asim on 05/05/2024.
//

import Foundation
import CoreLocation

class LocationVM {
    
    private let locationService = LocationService()
    private let notificationService = NotificationService()
    
    private var geofence: Geofence?
    private var entryTimestamp: Date?
    private var exitTimestamp: Date?
    
    var locationServiceAuthorized: ((String, String) -> ())?
    var locationServiceDisabled: ((String, String) -> ())?
    var geofenceMontitoringStarted: ((CLRegion) -> ())?
    var dwellTimeUpdated: ((String) -> ())?

    init() {
        locationService.locationServiceDelegate = self
        locationService.geofenceDelegate = self
    }
    
}

// MARK: - Location Permission
extension LocationVM {
    
    func handleLocationPermission() {
        let locPermissionStatus = locationService.getLocationPermissionStatus()
        switch locPermissionStatus {
        case .authorized:
            locationServiceAuthorized?(locPermissionStatus.title, locPermissionStatus.message)
        case .denied:
            locationServiceDisabled?(locPermissionStatus.title, locPermissionStatus.message)
        case .restricted:
            locationServiceDisabled?(locPermissionStatus.title, locPermissionStatus.message)
        case .notDetermined:
            locationService.requestLocationPermission()
        }
    }
}

// MARK: - Notification Permission
extension LocationVM {
    
    func requestNotificationsPermission() {
        notificationService.requestNotificationPermission()
    }
}

// MARK: - Geofence
extension LocationVM {
    
    ///setup and start monitoring geofence
    func startMonitoringGeofence(latitude: String, longitude: String, radius: String) {
        setupGeofence(latitude: latitude, longitude: longitude, radius: radius)
        
        guard let geofence = geofence else { return }
        locationService.startMonitoringGeofence(geofence: geofence, geofenceId: "geofenceId")
    }
    
    ///stop monitoring geofences and reset geofence object
    func stopMonitoringGeofence() {
        locationService.stopMonitoringGeofence()
        resetGeofence()
    }
    
    ///setup geofence for the given latitude, longitude and radius
    private func setupGeofence(latitude: String, longitude: String, radius: String) {
        guard let latitude = Double(latitude), let longitude = Double(longitude), let radius = Double(radius) else { return }
        let radiusDistance = CLLocationDistance(radius)
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        geofence = Geofence(center: center, radius: radiusDistance)
    }
    
    private func resetGeofence() {
        geofence = nil
    }
    
    private func resetGeofenceTimestampValues() {
        entryTimestamp = nil
        exitTimestamp = nil
    }
}

// MARK: - Location Service Delegate
extension LocationVM: LocationPermissionDelegate {
    func didUpdateLocationPermissionStatus(_ status: CLAuthorizationStatus) {
        handleLocationPermission()
    }
}

// MARK: - Geofence Delegate
extension LocationVM: GeofenceDelegate {
    func didStartMontitoring(_ region: CLRegion) {
        geofenceMontitoringStarted?(region)
    }
    
    func didEnterGeofence(_ timestamp: Date) {
        entryTimestamp = timestamp
        logEvent(eventType: .enter, timestamp: timestamp)
        sendNotification(eventType: .enter, timestamp: timestamp)
    }
    
    func didExitGeofence(_ timestamp: Date) {
        exitTimestamp = timestamp
        logEvent(eventType: .exit, timestamp: timestamp)
        sendNotification(eventType: .exit, timestamp: timestamp)
        calculateDwellTime()
        resetGeofenceTimestampValues()
    }
}

//MARK: - Helper functions
extension LocationVM {
    
    ///Prints the LocationEvent to console
    private func logEvent(eventType: LocationEventType, timestamp: Date) {
        print(eventType.title, "\(String(describing: geofence)) at: \(timestamp)")
    }
    
    ///send a local notification for the LocationEvent
    private func sendNotification(eventType: LocationEventType, timestamp: Date) {
        notificationService.sendNotification(title: eventType.title, body: "\(eventType.message)  Region: \(String(describing: geofence)) at: \(timestamp)")
    }
    
    ///calculates swell time inside a geofence
    private func calculateDwellTime() {
        guard let entryTimestamp = entryTimestamp, let exitTimestamp = exitTimestamp else { return }
        let dwellTime = exitTimestamp.timeIntervalSince(entryTimestamp)
        self.dwellTimeUpdated?(dwellTime.description)
    }
}

