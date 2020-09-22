//
//  LocationInteractor.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation

enum StateRoute {
    case start
    case restart
    case pause
    case finish
}

class LocationInteractor: LocationContractInteractor{
    
    var callback: LocationContractCallback?
    var listPositions = [LocationDB]()
    var count = 0
    var state: StateRoute?
    
    func createDB() {
        try! LocationDao.create()
    }
    
    func gpsDataCollector() {
        if let filepath = Bundle.main.path(forResource: "coordenadas", ofType: "txt") {
            do {
                
                let data = try String(contentsOfFile: filepath)
                let listLocations = data.components(separatedBy: .newlines)
                
                guard listLocations.count > 0 else { return }
                try! LocationDao.cleanTable()
                
                for (index, value) in listLocations.enumerated(){
                    let location = value.components(separatedBy: ", ")
                    guard location.count > 1 else { return }
                    
                    let point = LocationDB(latitude: Double(location[0]), longitude: Double(location[1]), position: index)
                    Queries.insertPoint(point: point)
                }
                
                self.listPositions = Queries.getAllPoints()
                
            } catch {
                print("El contenido no puede cargarse")
            }
        } else {
            print("coordenadas.txt no ha sido encontrado!")
        }
    }
    
    func publisher(state: StateRoute) {
        self.state = state
        
        switch state {
            
        case StateRoute.start:
            self.count = 0
            repeatLoop()
            break
            
        case StateRoute.restart:
            repeatLoop()
            break
            
        default:
            break
        }
        
    }
    
    func setCallback(callback: LocationContractCallback) {
        self.callback = callback
    }
    
    private func repeatLoop(){
        if state == StateRoute.start || state == StateRoute.restart{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                self.updateLocation()
                self.repeatLoop()
            }
        }
    }
    
    private func updateLocation(){
        guard count < listPositions.count else {
            self.state = StateRoute.finish
            callback?.finishRoute()
            return
        }
        let location = Queries.getLocationForPosition(position: count)
        guard location != nil else { return }
        callback?.actualPosition(location: location!)
        self.count += 1
    }
    
    
}
