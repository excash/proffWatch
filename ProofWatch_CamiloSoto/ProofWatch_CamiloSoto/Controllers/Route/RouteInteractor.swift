//
//  RouteInteractor.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation
import MapKit

class RouteInteractor: RouteContractInteractor{

    var callback: RouteContractCallback?

    //Carga de los datos de los puntos del recorrido
    func loadRoute() {
        let listLocations = Queries.getAllPoints()
        var locations = [CLLocationCoordinate2D]()
        
        for item in listLocations {
            let loc = CLLocationCoordinate2D(latitude: item.latitude ?? 4, longitude: item.longitude ?? -74)
            locations.append(loc)
        }
        calculateDistance(locations: locations)
        callback?.returnLocations(locations: locations)
    }

    func setCallback(callback: RouteContractCallback) {
        self.callback = callback
    }
    
    // Funcion para calcular la distancia en Kilometros entre el opunto inicial y el final
    private func calculateDistance(locations: [CLLocationCoordinate2D]){
        var distance: Double = 0
        
        for (index, value) in locations.enumerated() {
            if index > 0 {
                let point1 = MKMapPoint(locations[index - 1])
                let point2 = MKMapPoint(value)
                
                distance = point1.distance(to: point2) + distance
            }
        }
        
        distance = distance / 1000
        let distanceStr = NSString(format: "%.2f", distance)
        
        self.callback?.returnDistance(distance: "\(distanceStr) KM")
    }
}
