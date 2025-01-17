//
//  MapViewCoordinator.swift
//  Maps
//
//  Created by Mohammad Azam on 1/3/22.
//

import Foundation
import MapKit

final class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation as? PlaceAnnotation else {
            return
        }
        
        view.canShowCallout = true
        view.detailCalloutAccessoryView = PlaceCalloutView(annotation: annotation, selectShowDirections: { [weak self] place in
            
            let start = MKMapItem.forCurrentLocation()
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: place.coordinate))
            
            self?.calculateRoute(start: start, destination: destination) { route in
                if let route = route {
                    
                    view.detailCalloutAccessoryView = nil
                    
                    let controller = RouteContentViewController(route: route)
                    let routePopover = RoutePopover(controller: controller)
                    
                    let positioningView = NSView(frame: NSRect(x: mapView.frame.width/2.6, y: 0, width: mapView.frame.width/2, height: 30.0))
                    
                    mapView.addSubview(positioningView)
                    
                    // clear all overlays
                    mapView.removeOverlays(mapView.overlays)
                    
                    // add overlay on the map
                    mapView.addOverlay(route.polyline, level: .aboveRoads)
                    
                    routePopover.show(relativeTo: positioningView.frame, of: positioningView, preferredEdge: .minY)
                    
                }
            }
            
        })
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = NSColor.purple
        return renderer
        
    }
    
    
    func calculateRoute(start: MKMapItem, destination: MKMapItem, completion: @escaping (MKRoute?) -> Void) {
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.transportType = .automobile
        directionsRequest.source = start
        directionsRequest.destination = destination
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculate { response, error in
            if let error = error {
                print("Unable to calculate directions \(error)")
                return
            }
            
            guard let response = response,
                  let route = response.routes.first else {
                      return
                  }
            
           completion(route)
        }
        
    }
    
}
