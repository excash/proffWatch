//
//  LocationContract.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation
import MapKit

protocol LocationContractView {
    func showActualPosition(location: CLLocationCoordinate2D)
    func showAllRoute()
}

protocol LocationContractPresenter {
    func startRoute(state: StateRoute)
}

protocol LocationContractInteractor {
    func createDB()
    func gpsDataCollector()
    func publisher(state: StateRoute)
    func setCallback(callback: LocationContractCallback)
}

protocol LocationContractCallback {
    func actualPosition(location: LocationDB)
    func finishRoute()
}
