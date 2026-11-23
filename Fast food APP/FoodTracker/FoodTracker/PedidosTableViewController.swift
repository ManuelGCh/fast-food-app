import UIKit
import os.log

class PedidosTableViewController: UITableViewController {

    var pedidos = [pedido]()
    
//Función para cargar los datos en la vista
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return pedidos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PedidosTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PedidosTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        var pedidoss = pedidos[indexPath.row]
        cell.plato.text = pedidoss.plato.name
        cell.foto.image = pedidoss.plato.photo
        cell.precio.text = String(pedidoss.precio)
        cell.unidades.text = String(pedidoss.unidades)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pedidos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

//Función para guardar los pedidos en el tableView
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pedidos, toFile: pedido.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }

//Función para cargar los pedidos en el tableView
    private func loadPedidos() -> [pedido]?  {
        return pedidos
    }
    
}
