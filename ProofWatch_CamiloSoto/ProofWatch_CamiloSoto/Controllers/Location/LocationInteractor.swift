//
//  LocationInteractor.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation


class LocationInteractor: LocationContractInteractor{
    
    var callback: LocationContractCallback?
    var listPositions = [LocationDB]()
    var count = 0
    var isFinished = false
    
    func createDB() {
        try! LocationDao.create()
    }
    
    func insertLocations() {
        if let filepath = Bundle.main.path(forResource: "coordenadas", ofType: "txt") {
            do {
                try! LocationDao.cleanTable()
                
                let data = try String(contentsOfFile: filepath)
                let listLocations = data.components(separatedBy: .newlines)
                
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
    
    func startRoute() {
        self.count = 0
        repeatLoop()
    }
    
    func setCallback(callback: LocationContractCallback) {
        self.callback = callback
    }
    
    private func repeatLoop(){
        if !isFinished{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                self.updateLocation()
                self.repeatLoop()
            }
        }
    }
    
    private func updateLocation(){
        guard count < listPositions.count else {
            self.isFinished = true
            print("Finalizo el recorrido!!!\n")
            return
        }
        callback?.actualPosition(position: self.listPositions[count])
        self.count += 1
    }
    
    
}
