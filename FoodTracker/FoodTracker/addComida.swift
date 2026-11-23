import UIKit
import os.log

class addComida: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nombreRestaurante: UILabel!
    @IBOutlet weak var nombreComida: UITextField!
    @IBOutlet weak var precioComida: UITextField!
    @IBOutlet weak var descripcionComida: UITextField!
    @IBOutlet weak var fotoComida: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var restaurante: Restaurante?
    var comida: Meal?
    
//Función para cargar los datos en la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreRestaurante.text = restaurante?.name
        
    }

//Funciones que nos permiten elegir una imagen desde la galería y ponerla en la comida que queremos añadir
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        fotoComida.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func seleccionarDesdeLibreria(_ sender: UITapGestureRecognizer) {
        nombreComida.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
   
//En el prepare, hacemos todos los pasos para pasar los datos entre vistas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let nombre = nombreComida.text ?? ""
        let precio = precioComida.text ?? ""
        let descripcion = descripcionComida.text ?? ""
        let photo = fotoComida.image
    
        comida = Meal(name: nombre,photo: photo, rating: 4,
                                   precio: Int(precioComida.text!)!,
                                   descripcion: descripcion)
    }
}

