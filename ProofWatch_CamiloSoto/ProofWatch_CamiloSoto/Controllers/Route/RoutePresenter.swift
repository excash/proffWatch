//
//  RoutePresenter.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation
import MapKit

class RoutePresenter: RouteContractPresenter, RouteContractCallback {
    
    var view: RouteContractView?
    var interactor: RouteContractInteractor?
    
    //Inicalización del Presentador
    init(view: RouteContractView, interactor: RouteContractInteractor) {
        self.view = view
        self.interactor = interactor
        self.interactor?.setCallback(callback: self)
        self.interactor?.loadRoute()
    }
    
    
    //MARK: Callback
    func returnDistance(distance: String) {
        self.view?.showDistance(distance: distance)
    }
    
    func returnLocations(locations: [CLLocationCoordinate2D]) {
        self.view?.showRoute(locations: locations)
    }
    
    
    
}
