//
//  LocationDao.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation
import GRDB

///Clase de la tabla Coordenadas
class LocationDao{
    
    //MARK: Variables
    
    static let NAME_TABLE = "LOCATION"
    static let ID = "id"
    static let LATITUDE = "LATITUDE"
    static let LONGITUDE = "LONGITUDE"
    static let POSITION = "POSITION"
    
    //MARK: - Creación de la entidad
    /**
     Función que crea o adiciona  las columnas de la tabla dependiendo de la versión de la migración
     */
    static func create() throws -> Void {
        var migrator = DatabaseMigrator()
        migrator.registerMigration("v1\(NAME_TABLE)") { db in
            
            try db.create(table: NAME_TABLE){ t in
                t.column(ID, .integer).primaryKey()
                t.column(LATITUDE, .double)
                t.column(LONGITUDE, .double)
                t.column(POSITION, .integer)
            }
        }
        try! migrator.migrate(DBManager.SharedInstance.getDBQueue())
        
    }
    
    /**
     Función para limpiar los datos de la tabla
     */
    static func cleanTable() throws -> Void {
        let queue = DBManager.SharedInstance.getDBQueue()
        try! queue.inTransaction { db in
            try db.execute(sql: "DELETE FROM \(NAME_TABLE)")
            return .commit
        }
    }
    
    /**
     Función que retorna un String con la concatenación de la consulta para seleccionar
     */
    static func getSelect() -> String{
        return "SELECT * FROM \(NAME_TABLE)"
    }
    /**
     Función que retorna el String pra la consulta con WHERE
     */
    static func getSelectWithQuery(query: String) -> String{
        return "\(getSelect()) WHERE \(query)"
    }
    /**
     Función que retorna un String con la consulta diferente a  WHERE
     */
    static func getSelectWithQueryNotWhere(query: String) -> String{
        return "\(getSelect()) \(query)"
    }
    /**
     Función que retorna un String con el Query para eliminar un dato por el ID
     */
    static func deleteRow(id: Int64) -> String {
        return "DELETE FROM \(NAME_TABLE) WHERE id = \(id)"
    }
}
