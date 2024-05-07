//
//  Constants.swift
//  GeofencingApp
//
//  Created by Khadija Asim on 05/05/2024.
//

import Foundation

struct K {
    
    struct LocationPermissionStatusTitle {
        static let authorized = "Location Services Authorized"
        static let denied = "Location Services Denied"
        static let notdetermined = "Location Services Authorization Pending"
        static let restricted = "Location Services Restricted"
    }
    
    struct LocationPermissionStatusMessage {
        static let authorized = "Enter values for latitude, longitude and radius to setup and monitor Geofence. Receive notifications on entry and exit of Geofence!"
        static let denied = "Location services are denied. Please enable location services in settings to continue using the application"
        static let notdetermined = "Location services authorization is pending. Please allow location access when prompted to continue using the application"
        static let restricted = "Location services are restricted on this device. Please enable location services in settings to continue using the application"
    }
    
    static let openSettingsString = "Open Settings"
    static let okString = "Ok"
}
