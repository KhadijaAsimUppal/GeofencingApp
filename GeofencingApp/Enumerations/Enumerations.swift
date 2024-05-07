//
//  Enumerations.swift
//  GeofencingApp
//
//  Created by Khadija Asim on 05/05/2024.
//

import Foundation


enum LocationPermissionStatus {
    case authorized
    case denied
    case notDetermined
    case restricted
    
    var title: String {
        switch self {
        case .authorized:
            return K.LocationPermissionStatusTitle.authorized
        case .denied:
            return K.LocationPermissionStatusTitle.denied
        case .notDetermined:
            return K.LocationPermissionStatusTitle.notdetermined
        case .restricted:
            return K.LocationPermissionStatusTitle.restricted
        }
    }
    
    var message: String {
        switch self {
        case .authorized:
            return K.LocationPermissionStatusMessage.authorized
        case .denied:
            return K.LocationPermissionStatusMessage.denied
        case .notDetermined:
            return K.LocationPermissionStatusMessage.notdetermined
        case .restricted:
            return K.LocationPermissionStatusMessage.restricted
        }
    }
}

enum LocationEventType {
    case enter
    case exit
    
    var title: String {
        switch self {
        case .enter:
            return K.LocationEventTitle.enter
        case .exit:
            return K.LocationEventTitle.exit
        }
    }
    
    var message: String {
        switch self {
        case .enter:
            return K.LocationEventMessage.enter
        case .exit:
            return K.LocationEventMessage.exit
        }
    }
}

enum NotificationPermissionStatus {
    case authorized
    case denied
    case notDetermined
    case provisional
    
    var message: String {
        switch self {
        case .authorized:
            return "Notification permission is authorized."
        case .denied:
            return "Notification permission is denied."
        case .notDetermined:
            return "Notification permission is not determined."
        case .provisional:
            return "Notification permission is provisional."
        }
    }
}

