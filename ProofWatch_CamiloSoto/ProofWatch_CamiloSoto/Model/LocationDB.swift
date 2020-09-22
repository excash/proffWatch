//
//  LocationDB.swift
//  ProofWatch_CamiloSoto
//
//  Created by Camilo Soto on 21/09/20.
//  Copyright © 2020 CamiloSoto. All rights reserved.
//

import Foundation
import GRDB

///Clase del objeto de Coordenadas
class LocationDB: Record{
    
    //MARK: Variables
    var id: Int64!
    var latitude: Double?
    var longitude : Double?
    var position: Int?
    
    /**
     Función de inicialización del objeto
     */
    init(latitude: Double? = nil, longitude : Double? = nil, position : Int? = nil){
        self.latitude = latitude
        self.longitude = longitude
        self.position = position
        super.init()
    }
    
    //MARK: - Record
    override class var databaseTableName: String {
        return LocationDao.NAME_TABLE
    }
    
    //MARK: propiedades de la tabla
    required init(row: Row) {
        id = row[LocationDao.ID]
        latitude = row[LocationDao.LATITUDE]
        longitude = row[LocationDao.LONGITUDE]
        position = row[LocationDao.POSITION]
        super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) {
        container[LocationDao.ID] = id
        container[LocationDao.LATITUDE] = latitude
        container[LocationDao.LONGITUDE] = longitude
        container[LocationDao.POSITION] = position
    }
    
    //MARK: Consultas
    /**
     Función para buscar todos los datos de la tabla
     */
    static func fetchAll(db: Database) -> [LocationDB] {
        return try! LocationDB.fetchAll(db, sql: LocationDao.getSelect())
    }
    /**
     Función que busca los datos de una tabla mediante un Query
     */
    static func fetchAllWithQuery(_ db: Database, _ query: String) -> [LocationDB] {
        return try! LocationDB.fetchAll(db, sql: LocationDao.getSelectWithQuery(query: query))
    }
    /**
     Función que busca los datos de la tabla por un Query diferente al WHERE
     */
    static func fetchAllWithOtherQuery(db: Database, query: String) -> [LocationDB]{
        return try! LocationDB.fetchAll(db, sql: LocationDao.getSelectWithQueryNotWhere(query: query))
    }
    /**
     Función que busca un solo elemento mediante un Query
     */
    static func fetchOneWithQuery(_ db: Database, _ query : String) -> LocationDB? {
        return try! LocationDB.fetchOne(db, sql: LocationDao.getSelectWithQuery(query: query))
    }
    /**
     Función que elimina un fila de la tabla por ID
     */
    static func deleteRow(_ db: Database, _ id: Int64) -> LocationDB?{
        return try! LocationDB.fetchOne(db, sql: LocationDao.deleteRow(id: id))
    }
}
