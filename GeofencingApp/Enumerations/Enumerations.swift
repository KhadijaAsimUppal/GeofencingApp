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
    
    var messgae: String {
        switch self {
        case .enter:
            return "Entered region"
        case .exit:
            return "Exit region"
        }
    }
}
