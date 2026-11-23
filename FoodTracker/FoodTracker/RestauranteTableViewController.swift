//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class RestauranteTableViewController: UITableViewController {
    
    
    var restaurantes = [Restaurante]()
    
//Función para cargar los datos en la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
       if let savedRestaurantes = loadRestaurantes() {
            restaurantes += savedRestaurantes
        }
        else {
            loadSampleRestaurantes()
       }
    }
    
//Aquí recibimos los warnings de memoria
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//Aquí tenemos las funciones que se encargan de llevar a cabo todo el procesamiento e
//integración de los datos en la tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RestauranteTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestauranteTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RestauranteTableViewCell.")
        }
        
        let restaurante = restaurantes[indexPath.row]
        
        cell.nameLabel.text = restaurante.name
        cell.ratingControl.rating = restaurante.rating
        cell.imagenRestaurante.image = restaurante.photo
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurantes.remove(at: indexPath.row)
            saveRestaurantes()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
//En el prepare, hacemos todos los pasos para pasar los datos entre vistas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new Restaurante.", log: OSLog.default, type: .debug)
            
         case "ShowDetail2":
            guard let selectedRestauranteCell = sender as? RestauranteTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedRestauranteCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let restauranteSeleccionado = restaurantes[indexPath.row]
          
            guard let restauranteDetail = segue.destination as? RestauranteViewDetail else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
           restauranteDetail.restaurante = restauranteSeleccionado
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: Private Methods
    
//En esta función cargamos los datos por defecto que queremos que salgan en nuestra app
    private func loadSampleRestaurantes() {
        let foster1a = UIImage(named: "foster1a")
        let foster2a = UIImage(named: "foster2a")
        let foster3a = UIImage(named: "foster3a")
        let foster4a = UIImage(named: "foster4a")
        let mcdonald1a = UIImage(named: "mcdonald1a")
        let mcdonald2a = UIImage(named: "mcdonald2a")
        let mcdonald3a = UIImage(named: "mcdonald3a")
        let mcdonald4a = UIImage(named: "mcdonald4a")
        let vips1a = UIImage(named: "vips1a")
        let vips2a = UIImage(named: "vips2a")
        let vips3a = UIImage(named: "vips3a")
        let vips4a = UIImage(named: "vips4a")
    
        let photo4 = UIImage(named: "McDonald")
        let photo5 = UIImage(named: "Foster")
        let photo6 = UIImage(named: "Vips")
        
        guard let foster1 = Meal(name: "Black Label Burguer",photo: foster1a, rating: 4,precio: 12,descripcion: "Pan con sabor a trufa, queso cheddar y cebolla morada confitada al oporto. Acompañado de mayonesa con sabor a trufa y rúcula.") else {
                                    fatalError("Unable to instantiate meal2")
        }
        
        guard let foster2 = Meal(name: "National Star Ribs",
                                 photo: foster2a, rating: 5,
                                 precio: 15,
                                 descripcion: "Costillas de cerdo ahumadas a la parrilla") else {
                                    fatalError("Unable to instantiate meal2")
        }
        
        guard let foster3 = Meal(name: "Bacon & Cheese Fries",
                                 photo: foster3a, rating: 3,
                                 precio: 7,
                                 descripcion: "Patatas fritas, mix de quesos y bacon crispy con salsa ranchera.") else {
                                    fatalError("Unable to instantiate meal2")
        }
        
        guard let foster4 = Meal(name: "All Strar Brownie",
                                 photo: foster4a, rating: 5,
                                 precio: 5,
                                 descripcion: "Brownie caliente de chocolate, acompañado de helado de vainilla, cubierto con nueces y nuestra salsa de chocolate caliente.") else {
                                    fatalError("Unable to instantiate meal2")
        }
        
        
        guard let mcdonald1 = Meal(name: "Grand McExtreme Intense Cheddar",
                                   photo: mcdonald1a, rating: 3,
                                   precio: 7,
                                   descripcion: "Jugosa carne 100% vacuno español, bacon, queso Cheddar e irresistible salsa Cheddar. Si eres amante del Cheddar, disfruta de tu locura por el queso con esta hamburguesa.") else {
                                    fatalError("Unable to instantiate meal2")
        }
        
        guard let mcdonald2 = Meal(name: "McWrap® Chicken & Bacon",
                                   photo: mcdonald2a, rating: 4,
                                   precio: 6,
                                   descripcion: "No te pierdas una deliciosa mezcla de pollo de primera calidad, sabroso bacon, queso, tomate, lechuga y salsa Supreme.") else {
                                    fatalError("Unable to instantiate meal2")
        }
        
        guard let mcdonald3 = Meal(name: "25 McNuggets",
                                   photo: mcdonald3a, rating: 3,
                                   precio: 6,
                                   descripcion: "Disfruta en compañía de nuestras clásicas delicias de pollo rebozado ¡Tan irresistibles como el primer día!") else {
                                    fatalError("Unable to instantiate meal2")
        }
        
        guard let mcdonald4 = Meal(name: "McShake Nocilla",
                                   photo: mcdonald4a, rating: 3,
                                   precio: 3,
                                   descripcion: "¿Qué tendrá la Nocilla que gusta tanto a niños como a mayores? Y si encima viene bien fresquita en un delicioso McShake, ¡ya no hay quien se resista!") else {
                                    fatalError("Unable to instantiate meal2")
        }
        
        guard let vips1 = Meal(name: "Dip de Guacamole",
                               photo: vips1a, rating: 5,
                               precio: 6,
                               descripcion: "Tortillas de maíz acompañadas de Guacamole y pico de gallo.") else {
                                fatalError("Unable to instantiate meal2")
        }
        
        
        guard let vips2 = Meal(name: "Pizza Chicken BBQ",
                               photo: vips2a, rating: 4,
                               precio: 9,
                               descripcion: "Dados de pollo acompañados de pimiento rojo, cebolla roja, salsa BBQ Chipotle y perejil sobre Mozzarella fundida. Sobre una base de pan de focaccia con salsa de tomate.") else {
                                fatalError("Unable to instantiate meal2")
        }
        
        guard let vips3 = Meal(name: "Sandwich Beef&Dip",
                               photo: vips3a, rating: 5,
                               precio: 8,
                               descripcion: "Crujiente pan de chapata cristal, deliciosa carne de vacuno a la plancha, queso suizo, champiñones salteados, espinacas y nuestra salsa Baconesa") else {
                                fatalError("Unable to instantiate meal2")
        }
        
        guard let vips4 = Meal(name: "Oreo Surprise",
                               photo: vips4a, rating: 4,
                               precio: 5,
                               descripcion: "Galletas Oreo recubiertas con nuestra famosa masa de tortitas VIPS y acompañadas de una bola de helado de vainilla, sirope de chocolate y trocitos de Oreo. (Se sirven calientes).") else {
                                fatalError("Unable to instantiate meal2")
        }

        
        guard let restaurante1 = Restaurante(name: "McDonald", direccion: "Jaén", correo:"aaa@gamil.com", telefono:"948375849", rating: 4,photo: photo4, comidas: [mcdonald1,mcdonald2,mcdonald3,mcdonald4], descripcion:"Para comida deliciosa, ¡visita McDonald's hoy! Mira nuestra amplia selección de comidas, snacks, bebidas y más.",localizador:"www.mcdonald.com") else {
            fatalError("Unable to instantiate restaurante1")
        }
        
        guard let restaurante2 = Restaurante(name: "Foster", direccion: "Córdoba",correo:"aaa@gamil.com", telefono:"948375849", rating: 5,photo: photo5, comidas: [foster1,foster2,foster3,foster4],  descripcion:"¿Qué te apetece hoy? Elige tu comida favorita de la carta de Foster's y te lo llevamos a casa. +info. Más de 200 restaurantes. Ambiente made in USA. Conoce nuestras ofertas. Auténtico sabor americano.",localizador:"www.fosterhollywood.com") else {
            fatalError("Unable to instantiate restaurante2")
        }
        
        guard let restaurante3 = Restaurante(name: "Vips", direccion: "Jaén",correo:"aaa@gamil.com", telefono:"948375849", rating: 3,photo: photo6, comidas: [vips1,vips2,vips3,vips4],  descripcion:"En VIPS tenemos comida para todos los gustos, con más de 60 platos que puedes disfrutar durante todo el día. ¡Y no te olvides de visitar nuestra tienda!",localizador:"www.vips.com") else {
            fatalError("Unable to instantiate restaurante3")
        }
        
        restaurantes += [restaurante1, restaurante2, restaurante3]
    }
    
//Función para guardar los restaurantes en el tableView
    public func saveRestaurantes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(restaurantes, toFile: Restaurante.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Restaurantes successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save restaurantes...", log: OSLog.default, type: .error)
        }
    }
    
//Función para cargar los restaurantes en el tableView
    private func loadRestaurantes() -> [Restaurante]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Restaurante.ArchiveURL.path) as? [Restaurante]
    }
    
//Función utilizada a la hora de guardar un nuevo restaurante
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RestauranteViewController, let restau = sourceViewController.restaurante {
            
            let newIndexPath = IndexPath(row: restaurantes.count, section: 0)
            
            restaurantes.append(restau)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        saveRestaurantes()
    }
    
}
