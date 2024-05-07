Overview
- GeofencingApp is a location-based iOS application designed to monitor geographic regions and provide notifications when users enter or exit these predefined areas. 
------------------------------------------------------------------------------
Features
- Geofence Setup: Users can define custom geofences by specifying latitude, longitude, and radius.
- Real-time Monitoring: The app continuously monitors the user's location and triggers notifications upon entering or exiting geofenced areas.
- Notification System: Utilizes User Notifications framework to deliver timely alerts to users.
- Location Permission Handling: Guides users through the process of granting location permissions for optimal functionality.
------------------------------------------------------------------------------
Implementation

LocationService
- Manages location-related tasks such as requesting permissions and monitoring geofences.
- Implements CLLocationManagerDelegate methods for handling location updates and region monitoring.

NotificationService
- Handles notification-related tasks such as requesting permissions and sending notifications.
- Utilizes UNUserNotificationCenter for managing notification requests and delivery.

LocationVM (Location ViewModel)
- Acts as an intermediary between the UI and LocationService.
- Handles user interactions, permissions, and geofence setup.

LocationVC (Location View Controller)
- Manages the user interface for setting up geofences and displaying relevant information.
- Utilizes closures to handle callbacks from LocationVM.
------------------------------------------------------------------------------
Usage
- Grant Location Permissions: Upon launching the app, users are prompted to grant location permissions.
- Grant Notification Permissions: Upon launching the app, users are prompted to grant notification permissions.
- Set up Geofences: Users can define custom geofences by entering latitude, longitude, and radius values.
- Monitor Geofences: The app continuously monitors the user's location and sends notifications when entering or exiting geofenced areas.
- Notification Handling: Users receive notifications on their device when geofence events occur.
------------------------------------------------------------------------------
Dependencies
- Core Location framework
- User Notifications framework
------------------------------------------------------------------------------
Compatibility
- iOS 15.0 and later
- Compatible with iPhone and iPad devices
