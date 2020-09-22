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
}

protocol LocationContractPresenter {
    func startRoute()
}

protocol LocationContractInteractor {
    func createDB()
    func insertLocations()
    func startRoute()
    func setCallback(callback: LocationContractCallback)
}

protocol LocationContractCallback {
    func actualPosition(position: LocationDB)
}
