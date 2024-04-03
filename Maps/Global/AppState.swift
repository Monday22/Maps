//
//  AppState.swift
//  Maps
//
//  Created by Mohammad Azam on 1/4/22.
//

import Foundation

class AppState: ObservableObject {
    @Published var places: [PlaceAnnotation] = []
    @Published var selectedPlace: PlaceAnnotation?
}
