import Foundation
import UIKit
import os.log
import MessageUI

class CompletarPedido: UIViewController, MFMailComposeViewControllerDelegate{
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var TelefonoTextField: UITextField!
    @IBOutlet weak var DireccionTextField: UITextField!
    @IBOutlet weak var CorreoTextField: UITextField!
    
    var pedidos = [pedido]()
    
//Función para cargar los datos en la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        var precioTotal = 0
        for x in pedidos {
            precioTotal += x.precio
        }
        precioLabel.text = String(precioTotal)
    }
    
//En el prepare, hacemos todos los pasos para pasar los datos entre vistas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail9":
            
            guard let detallespedidos = segue.destination as? PedidosTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            detallespedidos.pedidos = pedidos
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
//Función que actúa cuando realizamos el pedido, donde comprueba los campos para que sean válidos y envía un email
    @IBAction func realizarPedido(_ sender: UIButton) {
        if(TelefonoTextField.text!.isEmpty || DireccionTextField.text!.isEmpty || CorreoTextField.text!.isEmpty){
            if(TelefonoTextField.text!.isEmpty){
                let alerta = UIAlertController(title: "Error",
                                               message: "Introduce el teléfono",
                                               preferredStyle: UIAlertControllerStyle.alert)
                let accion = UIAlertAction(title: "Cerrar",
                                           style: .destructive)
                alerta.addAction(accion)
                self.present(alerta, animated: true, completion: nil)
            }
            if(DireccionTextField.text!.isEmpty){
                    let alerta = UIAlertController(title: "Error",
                                                   message: "Introduce la dirección",
                                                   preferredStyle: UIAlertControllerStyle.alert)
                    let accion = UIAlertAction(title: "Cerrar",
                                               style: .destructive)
                    alerta.addAction(accion)
                    self.present(alerta, animated: true, completion: nil)
                }
                if(CorreoTextField.text!.isEmpty){
                    let alerta = UIAlertController(title: "Error",
                                                   message: "Introduce el correo",
                                                   preferredStyle: UIAlertControllerStyle.alert)
                    let accion = UIAlertAction(title: "Cerrar",
                                               style: .destructive)
                    alerta.addAction(accion)
                    self.present(alerta, animated: true, completion: nil)
                }
        }else{
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            let alerta = UIAlertController(title: "Pedido enviado",
                                           message: "Le hemos enviado un correo de confirmación a "+CorreoTextField.text!,
                                           preferredStyle: UIAlertControllerStyle.alert)
            let accion = UIAlertAction(title: "Cerrar",
                                       style: .destructive)

            alerta.addAction(accion)
            self.present(alerta, animated: true, completion: nil)
        
        }
    }
    
//Estas funciones nos proporcionan la accion de enivar un correo una vez realizado un pedido
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["jsanore98@gmail.com"])
        mailComposerVC.setSubject("Enviando un email de confirmación.....")
        mailComposerVC.setMessageBody("¡Mensaje enviado!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "No se ha podido enviar el email", message: "El dispositivo no puede enviar un email. Conecte un dispositivo con cuenta.", delegate: self, cancelButtonTitle: "Aceptar")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismiss(animated:true, completion: nil)
    }
    
}
