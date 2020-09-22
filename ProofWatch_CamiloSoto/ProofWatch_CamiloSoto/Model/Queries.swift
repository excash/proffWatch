//
//  Queries.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation

//MARK: Variables
let queue = DBManager.SharedInstance.getDBQueue()

/**
 Clase que administra las consultas a la base de datos
 */
class Queries: NSObject {
    
    //MARK: Localización

    // Insertar un punto en la base de datos
    class func insertPoint(point: LocationDB){
        try! queue.inTransaction{ db in
            try! point.insert(db)
            return .commit
        }
    }
    
    // Obtener la coordenada por posicion en la cola
    class func getLocationForPosition(position: Int) -> LocationDB? {
        let location = queue.inDatabase{ db in
            LocationDB.fetchOneWithQuery(db, "\(LocationDao.POSITION) = \(position)")
        }
        return location
    }
    
    // Obtiene todas las coordenadas almacenadas
    class func getAllPoints() -> [LocationDB]{
        let listLocations = queue.inDatabase{db in
            LocationDB.fetchAll(db: db)
        }
        
        return listLocations
    }

}
