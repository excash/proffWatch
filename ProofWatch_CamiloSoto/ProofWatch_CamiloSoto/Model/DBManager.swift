//
//  DBManager.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import UIKit
import GRDB

///Clase para el manejo de la Base de Datos
class DBManager {
    
    //MARK: Variables
    static let SharedInstance = DBManager()
    fileprivate var dbQueue: DatabaseQueue
    
    fileprivate init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let databasePath = documentsPath.appendingPathComponent("db_proff_watcher.sqlite")
        dbQueue = try! DatabaseQueue(path: databasePath)
    }
    
    func getDBQueue() -> DatabaseQueue {
        return dbQueue
    }
}

