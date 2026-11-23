import UIKit

class PedidosTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var plato: UILabel!
    @IBOutlet weak var precio: UILabel!
    @IBOutlet weak var unidades: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
