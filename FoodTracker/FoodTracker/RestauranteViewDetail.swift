//
//  RestauranteViewDetail.swift
//  FoodTracker
//
//  Created by Manuel Gallego Chinchilla on 10/4/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import os.log

class RestauranteViewDetail: UIViewController{
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var LabelDescripcion: UILabel!
    @IBOutlet weak var LabelLocalizador: UILabel!
    @IBOutlet weak var LabelTelefono: UILabel!
    @IBOutlet weak var VerCartaButton: UIButton!

    var restaurante: Restaurante?
    var pedidos = [pedido]()
    
//Función para cargar los datos en la vista
    override func viewDidLoad() {
        super.viewDidLoad()
       if let restaurante = restaurante {
            navigationItem.title = restaurante.name
            imagen.image = restaurante.photo
            LabelDescripcion.text = restaurante.descripcion
            LabelTelefono.text = restaurante.telefono
            LabelLocalizador.text = restaurante.localizador
        }
    }
    
//En el prepare, hacemos todos los pasos para pasar los datos entre vistas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail3":
            
            guard let restauranteSeleccionado = segue.destination as? MealTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            restauranteSeleccionado.resta = restaurante
            restauranteSeleccionado.pedidos = pedidos
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
}


