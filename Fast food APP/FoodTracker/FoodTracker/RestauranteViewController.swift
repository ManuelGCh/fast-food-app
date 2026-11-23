//
//  restaurantesViewController.swift
//  FoodTracker

import UIKit
import os.log

class RestauranteViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telefonoTextField: UITextField!
    @IBOutlet weak var direccionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var imagenImageView: UIImageView!
    @IBOutlet weak var localizadorTextField: UITextField!
    
    var restaurante: Restaurante?
    
//Función para cargar los datos en la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        if let restaurante = restaurante {
            navigationItem.title = restaurante.name
            nameTextField.text = restaurante.name
            direccionTextField.text = restaurante.direccion
        }
    }
    
//En el prepare, hacemos todos los pasos para pasar los datos entre vistas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        if(!nameTextField.text!.isEmpty && !direccionTextField.text!.isEmpty && !correoTextField.text!.isEmpty && !telefonoTextField.text!.isEmpty && !descripcionTextField.text!.isEmpty && !localizadorTextField.text!.isEmpty){
                let name = nameTextField.text ?? ""
                let direccion = direccionTextField.text ?? ""
                var meals = [Meal]()
                let correo = correoTextField.text ?? ""
                let telefono = telefonoTextField.text ?? ""
                let photo = imagenImageView.image
                let descripcion = descripcionTextField.text ?? ""
                let localizador = localizadorTextField.text ?? ""

                restaurante = Restaurante(name: name, direccion: direccion,correo: correo, telefono:telefono, rating: 1,photo: photo, comidas: meals, descripcion:descripcion, localizador:localizador )
        }
    }
    
//Función para seleccionar una foto desde la libreria para asignársela al nuevo restaurante
    @IBAction func seleccionarDesdeLibreria(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imagenImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
//Función del botón de cancelar
    @IBAction func Cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
//Aquí comprobamos los parámetros para ver si son válidos a la hora de guardar el restaurante
    @IBAction func comprobarParametros(_ sender: UIBarButtonItem) {
        if(nameTextField.text!.isEmpty || direccionTextField.text!.isEmpty || correoTextField.text!.isEmpty || telefonoTextField.text!.isEmpty || descripcionTextField.text!.isEmpty || localizadorTextField.text!.isEmpty){
            let alerta = UIAlertController(title: "Error",
                                           message: "Debe rellenar todos los campos.",
                                           preferredStyle: UIAlertControllerStyle.alert)
            let accion = UIAlertAction(title: "Cerrar",
                                       style: .destructive)
            alerta.addAction(accion)
            self.present(alerta, animated: true, completion: nil)
        }
    }
}

