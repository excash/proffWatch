//
//  RouteContract.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation
import MapKit

protocol RouteContractView {
    func showDistance(distance: String)
    func showRoute(locations: [CLLocationCoordinate2D])
}

protocol RouteContractPresenter {
    
}

protocol RouteContractInteractor {
    func loadRoute()
    func setCallback(callback: RouteContractCallback)
}

protocol RouteContractCallback {
    func returnDistance(distance: String)
    func returnLocations(locations: [CLLocationCoordinate2D])
}
