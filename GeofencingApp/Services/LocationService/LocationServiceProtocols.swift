//
//  LocationServiceProtocols.swift
//  GeofencingApp
//
//  Created by Khadija Asim on 07/05/2024.
//

import Foundation
import CoreLocation

protocol LocationPermissionDelegate: AnyObject {
    func didUpdateLocationPermissionStatus(_ status: CLAuthorizationStatus)
}

protocol GeofenceDelegate: AnyObject {
    func didStartMontitoring(_ region: CLRegion)
    func didEnterGeofence(_ timestamp: Date)
    func didExitGeofence(_ timestamp: Date)
}
