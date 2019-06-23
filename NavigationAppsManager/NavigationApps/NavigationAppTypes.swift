//
//  NavigationApp.swift
//  NavigationAppsManager
//
//  Created by Angel Antonov on 23.06.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation
import MapKit

class NavigationAppsFactory {
    func createNavigationApp(navApp: NavigationAppTypes) -> NavigationAppp {
        switch navApp {
        case .google:
            return GoogleNavigationApp()
        case .maps:
            return MapsNavigationApp()
        case .waze:
            return WazeNavigationApp()
        case .here:
            return "HERE WeGo"
        case .none:
            return ""
        }
    }
}

protocol NavigationAppp {
    var title: String { get }
    var scheme: String { get }
    func open(with destinationLocation: LocationCoordinates, urlOpener: CanOpenURL)
}

extension NavigationAppp {
    func openLink(with urlString: String, urlOpener: CanOpenURL = UIApplication.shared) {
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        urlOpener.open(url: url)
    }
}

struct GoogleNavigationApp: NavigationAppp {
    var title: String = "Google Maps"
    var scheme: String = "comgooglemaps://"
    
    func open(with destinationLocation: LocationCoordinates, urlOpener: CanOpenURL = UIApplication.shared) {
        let urlString = "comgooglemaps://?saddr=&daddr=\(destinationLocation.lcLatitude),\(destinationLocation.lcLongitude)&zoom=14&views=traffic&directionsmode=driving"
        
        self.openLink(with: urlString, urlOpener: urlOpener)
    }
}

struct MapsNavigationApp: NavigationAppp {
    var title: String = "Maps"
    var scheme: String = "http://maps.apple.com"
    
    func open(with destinationLocation: LocationCoordinates, urlOpener: CanOpenURL = UIApplication.shared) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(destinationLocation.lcLatitude, destinationLocation.lcLongitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
            MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving
            ] as [String : Any]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.openInMaps(launchOptions: options)
    }
}

struct WazeNavigationApp: NavigationAppp {
    var title: String = "Waze"
    var scheme: String = "waze://"
    
    func open(with destinationLocation: LocationCoordinates, urlOpener: CanOpenURL = UIApplication.shared) {
        let urlString = "waze://?ll=\(destinationLocation.lcLatitude),\(destinationLocation.lcLongitude)&navigate=yes"
        self.openLink(with: urlString, urlOpener: urlOpener)
    }
}

struct HereWeGoNavigationApp: NavigationAppp {
    var title: String = "HERE WeGo"
    var scheme: String = "here-route://"
    
    func open(with destinationLocation: LocationCoordinates, urlOpener: CanOpenURL = UIApplication.shared) {
        let urlString = "here-route://mylocation/\(destinationLocation.lcLatitude),\(destinationLocation.lcLongitude)?m=d"
        self.openLink(with: urlString, urlOpener: urlOpener)
    }
}

struct SafariGoogleMapsNavigationApp: NavigationAppp {
    var title: String = "Google Web"
    var scheme: String = "http://maps.google.com"
    
    func open(with destinationLocation: LocationCoordinates, urlOpener: CanOpenURL) {
        let urlString = "http://maps.google.com?saddr=&daddr=\(destinationLocation.lcLatitude),\(destinationLocation.lcLongitude)&zoom=14&views=traffic&directionsmode=driving"
        self.openLink(with: urlString, urlOpener: urlOpener)
    }
}
