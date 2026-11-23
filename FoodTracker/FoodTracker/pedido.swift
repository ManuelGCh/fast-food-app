//
//  pedido.swift
//  FoodTracker
//
//  Created by Manuel Gallego Chinchilla on 26/4/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//
import UIKit
import os.log


class pedido: NSObject, NSCoding {
    
    //MARK: Properties
    var unidades: Int
    var Observaciones: String
    var precio: Int
    var plato: Meal
    var id: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("pedidos")
    
    //MARK: Types
    
    struct PropertyKey {
        static let unidades = "unidades"
        static let precio = "precio"
        static let Observaciones = "Observaciones"
        static let plato = "plato"
        static let id = "id"
    }
    
    //MARK: Initialization
    
    init?(unidades: Int, precio: Int, Observaciones: String, plato: Meal, id: Int) {
        
        // Initialize stored properties.
        self.unidades = unidades
        self.precio = precio
        self.Observaciones = Observaciones
        self.plato = plato
        self.id = id
        
    }
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(unidades, forKey: PropertyKey.unidades)
        aCoder.encode(precio, forKey: PropertyKey.precio)
        aCoder.encode(Observaciones, forKey: PropertyKey.Observaciones)
        aCoder.encode(plato, forKey: PropertyKey.plato)
        aCoder.encode(id, forKey: PropertyKey.id)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let Observaciones = aDecoder.decodeObject(forKey: PropertyKey.Observaciones) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let plato = aDecoder.decodeObject(forKey: PropertyKey.plato) as? Meal else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let unidades = aDecoder.decodeInteger(forKey: PropertyKey.unidades)
        let precio = aDecoder.decodeInteger(forKey: PropertyKey.precio)
        let id = aDecoder.decodeInteger(forKey: PropertyKey.id)
        
        // Must call designated initializer.
        self.init(unidades: unidades, precio: precio, Observaciones: Observaciones, plato: plato, id: id)
        
    }
}
