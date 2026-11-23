//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    var meals = [Meal]()
    var resta : Restaurante?
    var pedidos = [pedido]()

//Función para cargar los datos en la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            loadSampleMeals()
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
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        var meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        cell.precioLabel.text = meal.precio.description
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
//En el prepare, hacemos todos los pasos para pasar los datos entre vistas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail4":
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let comidaseleccionada = meals[indexPath.row]
            
            guard let detalles = segue.destination as? DescripcionPlato else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            detalles.plato = comidaseleccionada
            detalles.pedidos = pedidos
            
        case "ShowDetail11":
            guard let detalles = segue.destination as? addComida else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            detalles.restaurante = resta!
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
//Función para cargar los restaurantes en el tableView
    private func loadSampleMeals() {
        meals = resta!.comidas
    }
    
//Función para guardar los restaurantes en el tableView
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
//Función para cargar los restaurantes en el tableView
    private func loadMeals() -> [Meal]?  {
        return resta!.comidas
    }
    
//Función utilizada a la hora de guardar datos desde otra vista
    @IBAction func unwindToMealList1(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? addComida, let comid = sourceViewController.comida {
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            resta?.comidas.append(comid)
            meals.append(comid)
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        saveMeals()
    }

//Función utilizada a la hora de guardar datos desde otra vista
    @IBAction func unwindToMealList2(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DescripcionPlato{
             pedidos = sourceViewController.pedidos
        }
    }
}
