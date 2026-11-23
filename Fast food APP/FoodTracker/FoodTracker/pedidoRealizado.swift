import Foundation
import UIKit
import os.log

class pedidoRealizado: UIViewController{
    @IBOutlet weak var Correo: UILabel!
    
    //MARK: Properties
    var correoPedido: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let correoPedido = correoPedido {
            Correo.text = correoPedido
        }
    }
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
    }

    
    //MARK: Private Methods
    
}
