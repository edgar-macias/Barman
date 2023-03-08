//
//  ViewController.swift
//  Barman
//
//  Created by Edgar Macias on 28/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    static let ENDPOINT: String = "http://janzelaznog.com/DDAM/iOS/drinksimages/"
    
    var drink: Bebida?
    
    @IBOutlet weak var bebidaImage: UIImageView!
    
    @IBOutlet var drinkName: UILabel!
    
    @IBOutlet var drinkIngredient: UILabel!
    
    @IBOutlet var drinkIndications: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drinkName.text = self.drink!.name
        
        let ingredients = self.drink!.ingredients.components(separatedBy: ",")
        
        let bullet = "•  "
        var ingredientesLabel: String = ""
        let formatIngedientes: [String] = ingredients.map{"\(bullet) \($0)".trimmingCharacters(in: .whitespaces)}
        ingredientesLabel = formatIngedientes.joined(separator: "\n")
        
        self.drinkIngredient.numberOfLines = ingredients.count
        self.drinkIngredient.text = ingredientesLabel
        self.drinkIndications.text = self.drink!.directions
        
        print(ingredientesLabel)
        if let laURL = URL(string:"\(ViewController.ENDPOINT)\(self.drink!.img)") {
            let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
            let elReq = URLRequest (url: laURL)
            let task = session.dataTask(with: elReq) { bytes, response, error in
                if error == nil {
                    guard let data = bytes else { return }
                    DispatchQueue.main.async {
                        self.bebidaImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }


}

