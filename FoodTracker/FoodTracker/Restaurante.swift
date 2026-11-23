//
//  Restaurante.swift
//  FoodTracker
//
//  Created by Macosx on 13/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import os.log


class Restaurante: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var direccion: String
    var correo: String
    var telefono: String
    var rating: Int
    var photo: UIImage?
    var comidas: [Meal]
    var descripcion: String
    var localizador: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Restaurante")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let direccion = "direccion"
        static let photo = "photo"
        static let rating = "rating"
        static let comidas = "comidas"
        static let correo = "correo"
        static let telefono = "telefono"
        static let descripcion = "descripcion"
        static let localizador = "localizador"
    }
    
    //MARK: Initialization

    init?(name: String, direccion: String, correo: String, telefono: String, rating: Int, photo: UIImage?, comidas: [Meal], descripcion: String, localizador: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        guard !descripcion.isEmpty else {
            return nil
        }
        
        guard !localizador.isEmpty else {
            return nil
        }
        
        // La direccion no puede ser nula
        guard !direccion.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.correo = correo
        self.telefono = telefono
        self.rating = rating
        self.direccion = direccion
        self.photo = photo
        self.comidas = comidas
        self.descripcion = descripcion
        self.localizador = localizador
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(direccion, forKey: PropertyKey.direccion)
        aCoder.encode(correo, forKey: PropertyKey.correo)
        aCoder.encode(telefono, forKey: PropertyKey.telefono)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(comidas, forKey: PropertyKey.comidas)
        aCoder.encode(descripcion, forKey: PropertyKey.descripcion)
        aCoder.encode(localizador, forKey: PropertyKey.localizador)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Restaurante object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let comida = aDecoder.decodeObject(forKey: PropertyKey.comidas) as? [Meal] else {
            os_log("Unable to decode the name for a Restaurante object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        guard let direccion = aDecoder.decodeObject(forKey: PropertyKey.direccion)as? String else {
            os_log("Unable to decode the direccion for a Restaurante object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let correo = aDecoder.decodeObject(forKey: PropertyKey.correo)as? String else {
            os_log("Unable to decode the direccion for a Restaurante object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let telefono = aDecoder.decodeObject(forKey: PropertyKey.telefono)as? String else {
            os_log("Unable to decode the direccion for a Restaurante object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let descripcion = aDecoder.decodeObject(forKey: PropertyKey.descripcion)as? String else {
            os_log("Unable to decode the direccion for a Restaurante object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let localizador = aDecoder.decodeObject(forKey: PropertyKey.localizador)as? String else {
            os_log("Unable to decode the direccion for a Restaurante object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, direccion: direccion, correo: correo, telefono:telefono, rating: rating,photo: photo, comidas: comida, descripcion:descripcion, localizador:localizador)
        
    }
}
