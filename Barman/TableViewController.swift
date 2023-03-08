//
//  TableViewController.swift
//  Barman
//
//  Created by Edgar Macias on 28/02/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    static let ENDPOINT: String = "http://janzelaznog.com/DDAM/iOS/drinks.json"
    
    
    /// Lista de bebidas
    var bebidas = [Bebida]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Consultar el API y serializar el JSON
        if let url = URL(string: TableViewController.ENDPOINT) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
              guard let bytes = data else { return }
              DispatchQueue.main.async {
                  let bebidasJson = try? JSONDecoder().decode(Bebidas.self, from: bytes)
                  self.bebidas = bebidasJson!
                  self.tableView.reloadData()
              }
            }.resume()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.bebidas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBebida", for: indexPath)

        let personaje = self.bebidas[indexPath.row]
        cell.textLabel?.text = personaje.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bebida = self.bebidas[indexPath.row]
        performSegue(withIdentifier: "showBebida", sender: bebida)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showBebida"){
            let vc = segue.destination as! ViewController
            guard let bebida = sender as? Bebida else { return }
            vc.drink = bebida
        }
        
    }
}
