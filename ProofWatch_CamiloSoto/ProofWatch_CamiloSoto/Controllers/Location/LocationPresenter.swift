//
//  LocationPresenter.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation
import MapKit

class LocationPresenter: LocationContractPresenter, LocationContractCallback{
    
    var view: LocationContractView?
    var interactor: LocationContractInteractor?
    
    init(view: LocationContractView, interactor: LocationContractInteractor) {
        self.view = view
        self.interactor = interactor
        self.interactor?.setCallback(callback: self)
        self.interactor?.createDB()
        self.interactor?.gpsDataCollector()
    }
    
    // Presenter
    func startRoute(state: StateRoute) {
        self.interactor?.publisher(state: state)
    }
    
    // Location
    func actualPosition(location: LocationDB) {
        let location = CLLocationCoordinate2D(latitude: location.latitude ?? 4, longitude: location.longitude ?? -74)
        self.view?.showActualPosition(location: location)
    }
    
    func finishRoute() {
        self.view?.showAllRoute()
    }
    
    
}
