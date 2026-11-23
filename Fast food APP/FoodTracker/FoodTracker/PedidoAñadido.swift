import Foundation
import UIKit
import os.log

class PedidoAñadido: UIViewController{

    @IBOutlet weak var nombrePlato: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ingredientes: UILabel!
    
    //MARK: Properties
    var restaurante: Restaurante?
    var plato: Meal?
    var pedidos = [pedido]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let plato = plato {
            ImageView.image = plato.photo
            nombrePlato.text = plato.name
            ingredientes.text = plato.descripcion
        }
    }
}
