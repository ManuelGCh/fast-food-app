import Foundation
import UIKit
import os.log

class DescripcionPlato: UIViewController{
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ingredientesTextField: UILabel!
    @IBOutlet weak var observaciones: UITextField!
    @IBOutlet weak var Unidades: UITextField!

    var restaurante: Restaurante?
    var plato: Meal?
    var pedidos = [pedido]()
    
//Función para cargar los datos en la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        if let plato = plato {
            navigationItem.title = plato.name
            ImageView.image = plato.photo
            ingredientesTextField.text = plato.descripcion
        }
    }
    
//Función utilizada en el botón de cancelar
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
//En el prepare, hacemos todos los pasos para pasar los datos entre vistas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "ShowDetail5":
            guard let detalles = segue.destination as? CompletarPedido else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            let coste = plato!.precio * Int(Unidades.text!)!
            let idPedido = pedidos.count + 1
            guard let p = pedido(unidades: Int(Unidades.text!)!, precio: coste, Observaciones: observaciones.text!, plato: plato!, id: idPedido) else {
                fatalError("Unable to instantiate restaurante1")
            }
            var esta = false
            if(pedidos.isEmpty){
                pedidos.append(p)
            }else{
                for i in pedidos{
                    if(i.plato.name == p.plato.name){
                        esta = true
                    }
                }
                if(!esta){
                    pedidos.append(p)
                }
            }
            detalles.pedidos = pedidos
            
        default:
            guard let detalles = segue.destination as? MealTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }

            detalles.pedidos = pedidos
        }
    }
    
//Función que comprueba los campos a la hora de añadir pedido, y muestra una alerta
    @IBAction func aceptarPedido(_ sender: UIButton) {

        if(Unidades.text!.isEmpty){
            let alerta = UIAlertController(title: "Error",
                                           message: "Necesitas poner unidades válidas",
                                           preferredStyle: UIAlertControllerStyle.alert)
            let accion = UIAlertAction(title: "Cerrar",
                                       style: .destructive)
            alerta.addAction(accion)
            self.present(alerta, animated: true, completion: nil)
        }else{
            let coste = plato!.precio * Int(Unidades.text!)!
            let idPedido = pedidos.count + 1
            guard let p = pedido(unidades: Int(Unidades.text!)!, precio: coste, Observaciones: observaciones.text!, plato: plato!, id: idPedido) else {
                fatalError("Unable to instantiate restaurante1")
            }
            var esta = false
            if(pedidos.isEmpty){
                pedidos.append(p)
                let alerta = UIAlertController(title: "Mis pedidos",
                                               message: "Pedido añadido.",
                                               preferredStyle: UIAlertControllerStyle.alert)
                let accion = UIAlertAction(title: "Cerrar",
                                           style: .destructive)
                alerta.addAction(accion)
                self.present(alerta, animated: true, completion: nil)
            }else{
                for i in pedidos{
                    if(i.plato.name == p.plato.name){
                        esta = true
                    }
                }
                if(!esta){
                    pedidos.append(p)
                    let alerta = UIAlertController(title: "Mis pedidos",
                                                   message: "Pedido añadido.",
                                                   preferredStyle: UIAlertControllerStyle.alert)
                    let accion = UIAlertAction(title: "Cerrar",
                                               style: .destructive)
                    alerta.addAction(accion)
                    self.present(alerta, animated: true, completion: nil)
                }else{
                    let alerta = UIAlertController(title: "Error",
                                                   message: "Este plato ya ha sido añadido",
                                                   preferredStyle: UIAlertControllerStyle.alert)
                    let accion = UIAlertAction(title: "Cerrar",
                                               style: .destructive)
                    alerta.addAction(accion)
                    self.present(alerta, animated: true, completion: nil)
                }
            }
        }
    }
}

