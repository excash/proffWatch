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

    class func insertPoint(point: LocationDB){
        try! queue.inTransaction{ db in
            try! point.insert(db)
            return .commit
        }
    }
    
    class func getAllPoints() -> [LocationDB]{
        let listLocations = queue.inDatabase{db in
            LocationDB.fetchAll(db: db)
        }
        
        return listLocations
    }

}
